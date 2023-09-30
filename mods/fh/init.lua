local modname = minetest.get_current_modname()
local path = minetest.get_modpath(modname)
local S = default.get_translator

fh = {
    keys = dofile(path .. "/keys.lua"),
    settings = dofile(path .. "/settings.lua")
}
dofile(path .. "/utils.lua")

dofile(path .. "/mark_organics.lua")
dofile(path .. "/nodes.lua")

dofile(path .. "/mobs.lua")

dofile(path .. "/consume.lua")
dofile(path .. "/items.lua")
dofile(path .. "/hudbar.lua")
dofile(path .. "/human_sense.lua")
dofile(path .. "/class.lua")
dofile(path .. "/safezone.lua")
dofile(path .. "/flamer.lua")
dofile(path .. "/vine.lua")
dofile(path .. "/mapgen.lua")
dofile(path .. "/hive.lua")
dofile(path .. "/shop.lua")

local hbhunger = hbhunger or {hunger = {}, SAT_MAX = 0, set_hunger_raw = function() end}

function fh.step_player(player, dtime)
    local meta = player:get_meta()
    local class_is_survivor = fh.class_is_survivor(player)
    local biomass = meta:get_int(fh.keys.biomass)
    local harvest = meta:get_int(fh.keys.harvest)

    local pos = player:get_pos()
    local radius = 3
    local nodenames = {"group:hive"}
    
    local hive_blocks_near =  minetest.find_node_near(pos, radius, nodenames)

    local player_name = player:get_player_name()
    local hunger = hbhunger.hunger[player_name] or 0


    hunger = hunger - fh.settings.hunger_per_tick

    if class_is_survivor then
        -- do it
        -- idk
        -- damage humans standing on bad stuff
    else
        if hive_blocks_near then
            biomass = biomass + 1
            end
        if hunger and (hunger + 1 <= hbhunger.SAT_MAX ) and ( biomass > fh.settings.biomass_per_hunger) then
            hunger = hunger + 1
            biomass = biomass - fh.settings.biomass_per_hunger
            hunger = math.min(hunger, hbhunger.SAT_MAX)
        end
        hb.change_hudbar(player, fh.keys.biomass, biomass)
        hb.change_hudbar(player, fh.keys.harvest, harvest)
    end
    
    meta:set_int(fh.keys.harvest, harvest)
    meta:set_int(fh.keys.biomass, biomass)
    hbhunger.hunger[player_name] = hunger
    hbhunger.set_hunger_raw(player)

end










dofile(path .. "/register.lua")

