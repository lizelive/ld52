lh_player.class_survivor = 0
lh_player.class_scyther = 1



function get_class(player) return player:get_meta():get_int(lh_player.key.class) end
function set_class(player, class) return player:get_meta():set_int(lh_player.key.class, class) end

-- can be called as much as you want without causing problems
local function become_scyther(player)

    hb.hide_hudbar(player, identifier)
end

-- can be called as much as you want without causing problems
local function become_scyther(player)

    hb.hide_hudbar(player, identifier)
end
