minetest.register_on_dieplayer(function(player)
	convert_to_zombie(player)
end)

function convert_to_zombie(player)
	player:get_meta():set_string("is_zombie", "true")
end
