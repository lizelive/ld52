local modname = minetest.get_current_modname()
local path = minetest.get_modpath(modname)
local S = default.get_translator

update_timer = 0
local update_timer_step = 0.1

minetest.register_globalstep(function(dtime)
    update_timer = update_timer + dtime
    if update_timer >= update_timer_step then
        -- minetest.debug("so " .. update_timer)
        lh_player.step(dtime)
        for _, player in ipairs(minetest.get_connected_players()) do
            lh_player.step_player(player, dtime)
        end
        update_timer = 0
    end
end)

minetest.register_on_joinplayer(lh_player.setup_hudbar)
