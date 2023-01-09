local S = default.get_translator

-- TODO l of these should play sound when picked up

minetest.register_craftitem("fh:alien_fragment", {
	description = S("Alien Fragment"),
	inventory_image = "alien_fragment.png",
	-- on_use = minetest.item_eat(5),
	groups = {lh = 1, flammable = 0},
})


minetest.register_craftitem("fh:biomass", {
	description = S("Biomass"),
	inventory_image = "biomass.png",
	-- on_use = minetest.item_eat(5),
	groups = {lh = 1, flammable = 0},
})

-- high end alien material
-- made from condensed
minetest.register_craftitem("fh:chitin", {
	description = S("chitin"),
	inventory_image = "chitin.png",
	-- on_use = minetest.item_eat(5),
	groups = {lh = 1, flammable = 0},
})