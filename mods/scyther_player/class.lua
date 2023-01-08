local class_survivor = 0
local class_scyther = 1



function get_class(player) return player:get_meta():get_int() end
function set_class(player) return player:get_meta():set_int() end
-- can be called as much as you want without causing problems
function scyther_player.become_scyther(player)

    hb.hide_hudbar(player, identifier)
end

-- can be called as much as you want without causing problems
function scyther_player.become_human(player)

    hb.hide_hudbar(player, identifier)
end
