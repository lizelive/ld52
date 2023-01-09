local S = default.get_translator

local mod_def = minetest.get_modpath("default")

minetest.register_node("fh:flesh_raw", {
	description = "Fresh Flesh Block",
	tiles = {"alien_flesh_raw_top.png", "alien_flesh_raw_bottom.png", "alien_flesh_raw_side.png"},
	paramtype2 = "facedir",
	groups = {choppy = 1, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = mod_def and default.node_sound_leaves_defaults(),
	on_place = minetest.rotate_node,
	on_use = minetest.item_eat(20)
})

minetest.register_node("fh:flesh", {
	description = "Flesh Block",
	tiles = {"alien_flesh_top.png", "alien_flesh_bottom.png", "alien_flesh_side.png"},
	paramtype2 = "facedir",
	groups = {choppy = 1, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = mod_def and default.node_sound_leaves_defaults(),
	on_place = minetest.rotate_node,
	on_use = minetest.item_eat(20)
})

minetest.register_node("fh:meatblock_raw", {
	description = "Raw Meat Block",
	tiles = {"mobs_meat_raw_top.png", "mobs_meat_raw_bottom.png", "mobs_meat_raw_side.png"},
	paramtype2 = "facedir",
	groups = {choppy = 1, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = mod_def and default.node_sound_leaves_defaults(),
	on_place = minetest.rotate_node,
	on_use = minetest.item_eat(20)
})

minetest.register_node("fh:meatblock", {
	description = "Meat Block",
	tiles = {"mobs_meat_top.png", "mobs_meat_bottom.png", "mobs_meat_side.png"},
	paramtype2 = "facedir",
	groups = {choppy = 1, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = mod_def and default.node_sound_leaves_defaults(),
	on_place = minetest.rotate_node,
	on_use = minetest.item_eat(20)
})




minetest.register_node("fh:fleshy_block", {
	description = "Meat Block",
	tiles = {"fleshy_block.png"},
	groups = {choppy = 1, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = mod_def and default.node_sound_leaves_defaults(),
	on_place = minetest.rotate_node,
	on_use = minetest.item_eat(20)
})


minetest.register_node("fh:tendril", {
	description = "Meat Block",
	tiles = {"tendril_top.png", "tendril_top.png", "tendril.png"},
	groups = {choppy = 1, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = mod_def and default.node_sound_leaves_defaults(),
	on_place = minetest.rotate_node,
	paramtype2 = "facedir",
	on_use = minetest.item_eat(20)
})


minetest.register_node("fh:alienmetalblock", {
	description = "alien metal block",
	tiles = {"alien_metal_block.png"},
	is_ground_content = false,
	groups = {cracky = 1, level = 2},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("fh:alienmetal", {
	description = "alien metal",
	tiles = {"alien_metal.png"},
	is_ground_content = false,
	groups = {cracky = 1, level = 2},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("fh:alien_metal_with_vine_drill", {
	description = "alien metal with vine drill",
	tiles = {"corrupted_alien_metal.png", "alien_metal.png", "alien_metal.png^vine_drill.png"},
	is_ground_content = false,
	paramtype2 = "facedir",
	on_place = minetest.rotate_node,
	groups = {cracky = 1, level = 2},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("fh:alien_metal_with_climby_eye_vine", {
	description = "alien metal with climby_eye_vine",
	tiles = {"alien_metal.png", "alien_metal.png", "alien_metal.png^climby_eye_vine.png"},
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
	"fh:alienmetalblock",
	{cracky = 1, level = 2},
	{"alien_metal_block.png"},
	"alien metal Stair",
	"alien metal Slab",
	default.node_sound_metal_defaults(),
	true
)

my_register_stair_and_slab(
	"alienmetal",
	"fh:alienmetal",
	{cracky = 1, level = 2},
	{"alien_metal.png"},
	"alien metal Stair",
	"alien metal Slab",
	default.node_sound_metal_defaults(),
	true
)





local function register_node_with_alien_grass(name, base)
	minetest.register_node("fh:".. name .. "_with_alien_grass", {
		description = S(name .. " with Alien Grass"),
		tiles = {base .. "^alien_grass.png", base,
			{name = base.."^alien_grass_side.png",
				tileable_vertical = false}},
		groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1, hive = 1},
		drop = "default:dirt",
		sounds = default.node_sound_dirt_defaults({
			footstep = {name = "default_grass_footstep", gain = 0.25},
		}),
	})
end

register_node_with_alien_grass("dirt", "default_dirt.png")
register_node_with_alien_grass("fleshs", "fleshy_block.png")


-- minetest.register_node("fh:dirt_with_alien_grass", {
-- 	description = S("Dirt with Grass"),
-- 	tiles = {"default_dirt.png^alien_grass.png", "default_dirt.png",
-- 		{name = "default_dirt.png^alien_grass_side.png",
-- 			tileable_vertical = false}},
-- 	groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1, hive = 1},
-- 	drop = "default:dirt",
-- 	sounds = default.node_sound_dirt_defaults({
-- 		footstep = {name = "default_grass_footstep", gain = 0.25},
-- 	}),
-- })


local function add_simple_flower(name, desc, box, f_groups)
	-- Common flowers' groups
	f_groups.snappy = 3
	f_groups.flower = 1
	f_groups.flora = 1
	f_groups.attached_node = 1
	f_groups.hive = 1

	minetest.register_node("fh:" .. name, {
		description = desc,
		drawtype = "plantlike",
		waving = 1,
		tiles = { name .. ".png"},
		inventory_image =  name .. ".png",
		wield_image = name .. ".png",
		sunlight_propagates = true,
		paramtype = "light",
		walkable = false,
		buildable_to = true,
		groups = f_groups,

		is_ground_content = false,
		paramtype2 = "facedir",
		on_place = minetest.rotate_node,
		
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = box
		}
	})
end


add_simple_flower(
	"vine_drill",
	S("vine drill"),
	{-2 / 16, -0.5, -2 / 16, 2 / 16, 5 / 16, 2 / 16},
	{color_red = 1, flammable = 1, hive =1}
)

add_simple_flower(
	"alien_egg",
	S("alien egg"),
	{-2 / 16, -0.5, -2 / 16, 2 / 16, 5 / 16, 2 / 16},
	{color_red = 1, flammable = 1, hive =1, damage_per_second = 4 * 2,}
)








-- do the spread

local spread_correspondences = {
	["default:cobble"] = "default:mossycobble",
	["stairs:slab_cobble"] = "stairs:slab_mossycobble",
	["stairs:stair_cobble"] = "stairs:stair_mossycobble",
	["stairs:stair_inner_cobble"] = "stairs:stair_inner_mossycobble",
	["stairs:stair_outer_cobble"] = "stairs:stair_outer_mossycobble",
	["walls:cobble"] = "walls:mossycobble",
}
minetest.register_abm({
	label = "Harvest",
	nodenames = {"group:organic"},
	neighbors = {"group:hive"},
	interval = 1,
	chance = 10,
	catch_up = true,
	action = function(pos, node)
		minetest.swap_node(pos,
                           {name = "fh:dirt_with_alien_grass"})
						   
		-- local new_node = moss_correspondences[node.name]
		-- if new_node then
		-- 	minetest.swap_node(pos,
        --                    {name = new_node})
		-- end
	end
})