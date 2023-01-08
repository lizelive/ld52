local S = default.get_translator

minetest.register_craftitem("lh_items:alien_fragment", {
	description = S("Alien Fragment"),
	inventory_image = "alien_fragment.png",
	-- on_use = minetest.item_eat(5),
	groups = {lh = 1, flammable = 0},
})