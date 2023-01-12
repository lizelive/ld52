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

function fh.step_player(player, dtime)
    local meta = player:get_meta()
    local class_is_survivor = fh.class_is_survivor(player)
    local biomass = meta:get_int(fh.keys.biomass)
    local harvest = meta:get_int(fh.keys.harvest)
    if class_is_survivor then
        -- do it
        -- idk
    else
        hb.change_hudbar(player, fh.keys.biomass, biomass)
        hb.change_hudbar(player, fh.keys.harvest, harvest)
    end
    -- damage humans standing on bad stuff
end

dofile(path .. "/register.lua")
