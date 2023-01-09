local modname = minetest.get_current_modname()
local path = minetest.get_modpath(modname)
local S = default.get_translator

update_timer = 0
local update_timer_step = 0.1

minetest.register_globalstep(function(dtime)
    update_timer = update_timer + dtime
    if update_timer >= update_timer_step then
        -- minetest.debug("so " .. update_timer)
        fh.step(dtime)
        for _, player in ipairs(minetest.get_connected_players()) do
            fh.step_player(player, dtime)
        end
        update_timer = 0
    end
end)

minetest.register_on_joinplayer(function(player, last_login)
    fh.fix_player_nametag(player, last_login)
    fh.setup_hudbar(player, last_login)
    fh.class_become(player, last_login)
end)
