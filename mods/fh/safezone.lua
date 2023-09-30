local modname = minetest.get_current_modname()
local path = minetest.get_modpath(modname)
local S = default.get_translator

-- when player leaves their safezone, it despawns
-- despawns after 5 days as is
-- requires alien fragment to power for a day, limit 5
-- limit 1 per player


-- Path: mods/fh/safezone.lua

-- @class Safezone 
-- @field pos the location of the safezone
-- @field radius the radius of the safezone
-- @field owner the owner of the safezone
-- @field expiration the expiration time of the safezone
-- @field offline_players how many offline players in this safezone?

local Safezone = {}
local safezones = {}
local mod_storage = minetest.get_mod_storage()

local function in_safezone(pos)
    for _, safezone in pairs(safezones) do
        if Safezone.contains(safezone, pos) then
            return true
        end
    end
    return false
end


local function start_particlespawner(safezone, playername)
    local pos = safezone.pos
    local particlespawner_definition = {
        time = 0,
        radius = fh.settings.safezone_radius,
        pos = pos,
        amount = 100,
        vertical = true,
        texture = "reality_anchor.png",
        minsize = 10,
        maxsize = 10,
        minexptime = 1,
        maxexptime = 1,
    }
    if playername then
        particlespawner_definition.playername = playername
    end
    safezone.particlespawner = minetest.add_particlespawner(particlespawner_definition)
end

function Safezone.new(pos, player)
    local player_name = player:get_player_name()
    if in_safezone(pos) then
        minetest.chat_send_player(player_name, "This area is too close to another safezone")

        return nil
    end
    local self = setmetatable({}, {__index = Safezone})
    self.pos = pos
    self.id = minetest.pos_to_string(pos, 0)
    self.radius = fh.settings.safezone_radius
    self.owner = player_name
    self.expiration = os.time() + fh.settings.safezone_duration
    self.offline_players = 0 -- todo, this is wrong technically, could be player already there
    safezones[self.id] = self
    start_particlespawner(self)
    
    return self
end



function Safezone.contains(self, pos)
    return vector.distance(self.pos, pos) < self.radius
end

function Safezone.remove(self)
    minetest.delete_particlespawner(self.particlespawner)
    safezones[self.id] = nil
end

local function load()
    -- foreach player ever, load their safezone from metadata
        safezones = minetest.deserialize(mod_storage:get_string("safezones")) or {}
        for _, safezone in pairs(safezones) do
            -- setmetatable(safezone, {__index = Safezone})
            safezone.offline_players = safezone.offline_players or 0
            safezone.pos = vector.new(safezone.pos)
            start_particlespawner(safezone)
        end
    end


local function save()
    mod_storage:set_string("safezones", minetest.serialize(safezones))
end

minetest.register_on_shutdown(save)

local function periodic_save()
    save()
    minetest.after(120, periodic_save)
end

local function safezone_tick()
    local time = os.time()
    local online_players = minetest.get_connected_players()

    for id, safezone in pairs(safezones) do
        if time > safezone.expiration then
            Safezone.remove(safezone)
            break
        end
        safezone.online_players = 0
        for _, player in ipairs(online_players) do
            local pos = player:get_pos()
            if Safezone.contains(safezone, pos) then
                safezone.online_players = safezone.online_players + 1
            end
        end

        if safezone.online_players <= 0 and safezone.offline_players <= 0 then
            Safezone.remove(safezone)
            break
        end
    end
    
    minetest.after(1, safezone_tick)
end


minetest.register_node("fh:reality_anchor", {
    description = "prevents blocks from being broken in area",
    tiles = {"market_vertical.png", "market_vertical.png", "market.png^reality_anchor.png"},
	after_place_node = function(pos, placer, itemstack, pointed_thing)
    end
})






minetest.register_on_leaveplayer(function(player, timed_out)
    local pos = player:get_pos()
    for _, safezone in pairs(safezones) do
        if Safezone.contains(safezone, pos) then
            safezone.offline_players = safezone.offline_players + 1
        end
    end
    save()
end)

minetest.register_on_joinplayer(function(player)
    local pos = player:get_pos()
    local player_name = player:get_player_name()
    for _, safezone in pairs(safezones) do
        if Safezone.contains(safezone, pos) then
            safezone.offline_players = safezone.offline_players - 1
            start_particlespawner(safezone, player_name)
        end
    end
end)


minetest.register_chatcommand("ps", {
    params = "",
    privs = {
        -- server=true
    },

    description = S("protect blocks"),
    func = function(player_name, _)
        -- entity_modifier.disguise_to_model(player_name, "lh_mobs:tank", nil)
        local player = minetest.get_player_by_name(player_name)
        local meta = player:get_meta()
        local pos = player:get_pos()
        -- spawn a sphere of particles
        Safezone.new(pos, player)
            -- local ps_id = minetest.add_particlespawner(
            --     {
            --         time = 0,
            --         radius = 10,
            --         pos = 0,
            --         attached = player,
            --         amount = 100,
            --         vertical = true,
            --         texture = "default_wood.png",
            --         glow = 14
            --     })
    end
})

function minetest.is_protected(pos, digger)
    return in_safezone(pos)
end

minetest.is_protected = in_safezone

load()

minetest.after(1, safezone_tick)
minetest.after(120, periodic_save)
