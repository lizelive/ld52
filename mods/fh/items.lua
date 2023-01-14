local S = default.get_translator

-- TODO l of these should play sound when picked up

minetest.register_craftitem("fh:fragment", {
	description = S("Alien Fragment"),
	inventory_image = "alien_fragment.png",
	-- on_use = minetest.item_eat(5),
	groups = {lh = 1, flammable = 0},
})

minetest.register_craftitem("fh:scrap", {
	description = S("Scrap"),
	inventory_image = "scrap.png",
	-- on_use = minetest.item_eat(5),
	groups = {lh = 1, flammable = 0},
})

minetest.register_craftitem("fh:jelly", {
	description = S("Jelly"),
	inventory_image = "jelly.png",
	-- on_use = minetest.item_eat(5),
	groups = {lh = 1, flammable = 0},
})


minetest.register_craft({
	type = "cooking",
	output = "default:steel_ingot",
	recipe = "fh:scrap",
})


minetest.register_craft({
	type = "fuel",
	burntime = 400,
	recipe = "fh:jelly",
})