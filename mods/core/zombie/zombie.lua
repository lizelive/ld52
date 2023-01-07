player_api.register_model("zombie_character.b3d", {
	animation_speed = 30,
	textures = {"zombie_character.png"},
	animations = {},
	collisionbox = {-0.7, -1, -0.7, 0.7, 1.6, 0.7},
	stepheight = 0.6,
	eye_height = 2.47,
})

minetest.register_on_joinplayer(function(player, _)
	if player:get_meta():get_string("is_zombie") == "true" then
		convert_to_zombie(player)
	end
end)

minetest.register_on_dieplayer(function(player)
	convert_to_zombie(player)
end)

function convert_to_zombie(player)
	player:get_meta():set_string("is_zombie", "true")
	player_api.set_model(player, "zombie_character.b3d")
end
