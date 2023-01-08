local modname = minetest.get_current_modname()
local path = minetest.get_modpath(modname)
local S = default.get_translator

scyther_player = {
    keys = dofile(path.."/keys.lua"),
    settings = dofile(path.."/settings.lua"),
}


dofile(path.."/consume.lua")
