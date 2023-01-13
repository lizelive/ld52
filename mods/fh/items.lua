local S = default.get_translator

-- TODO l of these should play sound when picked up

minetest.register_craftitem("fh:fragment", {
	description = S("Alien Fragment"),
	inventory_image = "alien_fragment.png",
	-- on_use = minetest.item_eat(5),
	groups = {lh = 1, flammable = 0},
})

minetest.register_craftitem("fh:one", {
	description = S("Alien Fragment"),
	inventory_image = "alien_fragment.png",
	-- on_use = minetest.item_eat(5),
	groups = {lh = 1, flammable = 0},
})
