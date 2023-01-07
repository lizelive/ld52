local mod_def = minetest.get_modpath("default")

minetest.register_node("alien_blocks:flesh_raw", {
	description = "Fresh Flesh Block",
	tiles = {"alien_flesh_raw_top.png", "alien_flesh_raw_bottom.png", "alien_flesh_raw_side.png"},
	paramtype2 = "facedir",
	groups = {choppy = 1, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = mod_def and default.node_sound_leaves_defaults(),
	on_place = minetest.rotate_node,
	on_use = minetest.item_eat(20)
})

minetest.register_node("alien_blocks:flesh", {
	description = "Flesh Block",
	tiles = {"alien_flesh_top.png", "alien_flesh_bottom.png", "alien_flesh_side.png"},
	paramtype2 = "facedir",
	groups = {choppy = 1, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = mod_def and default.node_sound_leaves_defaults(),
	on_place = minetest.rotate_node,
	on_use = minetest.item_eat(20)
})

minetest.register_node("alien_blocks:meatblock_raw", {
	description = "Raw Meat Block",
	tiles = {"mobs_meat_raw_top.png", "mobs_meat_raw_bottom.png", "mobs_meat_raw_side.png"},
	paramtype2 = "facedir",
	groups = {choppy = 1, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = mod_def and default.node_sound_leaves_defaults(),
	on_place = minetest.rotate_node,
	on_use = minetest.item_eat(20)
})

minetest.register_node("alien_blocks:meatblock", {
	description = "Meat Block",
	tiles = {"mobs_meat_top.png", "mobs_meat_bottom.png", "mobs_meat_side.png"},
	paramtype2 = "facedir",
	groups = {choppy = 1, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = mod_def and default.node_sound_leaves_defaults(),
	on_place = minetest.rotate_node,
	on_use = minetest.item_eat(20)
})