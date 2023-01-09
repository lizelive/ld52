local modname = minetest.get_current_modname()
local path = minetest.get_modpath(modname)
local S = default.get_translator

lh_player = {
    keys = dofile(path .. "/keys.lua"),
    settings = dofile(path .. "/settings.lua")
}

dofile(path .. "/consume.lua")
dofile(path .. "/hudbar.lua")
dofile(path .. "/human_sense.lua")
dofile(path .. "/class.lua")

function lh_player.step_player(player, dtime) end

dofile(path .. "/register.lua")
