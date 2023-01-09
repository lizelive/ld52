local modname = minetest.get_current_modname()
local path = minetest.get_modpath(modname)
local S = default.get_translator

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

minetest.register_chatcommand("become_scyther", {
	params = "",
	privs = {
        -- server=true
    },
	description = S("become a scyther"),
	func = function(player_name, _)
		entity_modifier.disguise_to_model(player_name, "lh_mobs:tank", nil)
        local player = minetest.get_player_by_name(player_name)
        player_api.set_textures(player, {"player_scyther.png"}) --"player_back.png"
	end,
})

-- nuke area
-- minetest.delete_area(pos1, pos2)

minetest.clear_registered_biomes()


-- player_api.set_textures(player, textures)