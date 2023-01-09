local modname = minetest.get_current_modname()
local path = minetest.get_modpath(modname)
local S = default.get_translator

fh = {
    keys = dofile(path .. "/keys.lua"),
    settings = dofile(path .. "/settings.lua")
}
dofile(path .. "/utils.lua")
dofile(path .. "/consume.lua")
dofile(path .. "/hudbar.lua")
dofile(path .. "/human_sense.lua")
dofile(path .. "/class.lua")

function fh.step_player(player, dtime)
step_player

end

dofile(path .. "/register.lua")
