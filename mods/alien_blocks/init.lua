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


minetest.register_node("alien_blocks:alienmetalblock", {
	description = "alien metal block",
	tiles = {"alien_metal_block.png"},
	is_ground_content = false,
	groups = {cracky = 1, level = 2},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("alien_blocks:alienmetal", {
	description = "alien metal",
	tiles = {"alien_metal.png"},
	is_ground_content = false,
	groups = {cracky = 1, level = 2},
	sounds = default.node_sound_metal_defaults(),
})

local function my_register_stair_and_slab(subname, recipeitem, groups, images,
	desc_stair, desc_slab, sounds, worldaligntex)
stairs.register_stair(subname, recipeitem, groups, images, (desc_stair),
	sounds, worldaligntex)
stairs.register_stair_inner(subname, recipeitem, groups, images, "",
	sounds, worldaligntex, "Inner " .. desc_stair)
stairs.register_stair_outer(subname, recipeitem, groups, images, "",
	sounds, worldaligntex, ("Outer " .. desc_stair))
stairs.register_slab(subname, recipeitem, groups, images, (desc_slab),
	sounds, worldaligntex)
end

my_register_stair_and_slab(
	"alienmetalblock",
	"alien_blocks:alienmetalblock",
	{cracky = 1, level = 2},
	{"alien_metal_block.png"},
	"alien metal Stair",
	"alien metal Slab",
	default.node_sound_metal_defaults(),
	true
)
