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
local Safezone = {}
local function Safezone.new(pos, radius, owner, expiration)
    local self = setmetatable({}, {__index = Safezone})
    self.pos = pos
    self.radius = radius
    self.owner = owner
    self.expiration = expiration
    return self
end

local mod_storage = minetest.get_mod_storage()

local function load()
-- foreach player ever, load their safezone from metadata
    return minetest.deserialize(mod_storage:get_string("safezones")) or {}
end


local safezone = load()


local create(player)
    -- create safezone at player's location
    local safezone = {
        pos = player:get_pos(),
        radius = fh.settings.safezone_radius,
        owner = player:get_player_name(),
        expiration = os.time() + fh.settings.safezone_duration,
    }

end


local purge_unowned()
    -- remove all expired safezones
    for _, safezone in ipairs(safezone) do
        if os.time() > safezone.expiration then
            table.remove(safezone, _)
        end
    end

end

local function save()
    mod_storage:set_string("death_pos", minetest.serialize(data.death_pos))
    mod_storage:set_string("death_time", data.death_time)
end

minetest.register_on_shutdown(save)
minetest.register_on_leaveplayer(save)

local function periodic_save()
    save()
    minetest.after(120, periodic_save)
end
minetest.after(120, periodic_save)

return data