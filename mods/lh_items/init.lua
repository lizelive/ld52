local S = default.get_translator

-- TODO l of these should play sound when picked up

minetest.register_craftitem("lh_items:alien_fragment", {
	description = S("Alien Fragment"),
	inventory_image = "lh_alien_fragment.png",
	-- on_use = minetest.item_eat(5),
	groups = {lh = 1, flammable = 0},
})


minetest.register_craftitem("lh_items:biomass", {
	description = S("Biomass"),
	inventory_image = "lh_biomass.png",
	-- on_use = minetest.item_eat(5),
	groups = {lh = 1, flammable = 0},
})

-- high end alien material
-- made from condensed
minetest.register_craftitem("lh_items:chitin", {
	description = S("Biomass"),
	inventory_image = "lh_biomass.png",
	-- on_use = minetest.item_eat(5),
	groups = {lh = 1, flammable = 0},
})