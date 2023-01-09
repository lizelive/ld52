local modname = minetest.get_current_modname()
local path = minetest.get_modpath(modname)
local S = default.get_translator

mobs:alias_mob("fh:tank", "lh_mobs:dungeon_master")

mobs:register_egg("fh:tank", S("Tank"), "fire_basic_flame.png", 1)

dofile(path .. "/mob_spore.lua")