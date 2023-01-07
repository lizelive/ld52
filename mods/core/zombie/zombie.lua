minetest.register_on_dieplayer(function(player)
	convert_to_zombie(player)
end)

function convert_to_zombie(player)
	meta = player:get_meta()
	meta:set_string("is_zombie", "true")
end
