local modname = minetest.get_current_modname()
local path = minetest.get_modpath(modname)
local S = default.get_translator

minetest.register_node("fh:vine", {
	description = S("climby eye vine"),
	drawtype = "plantlike",
	tiles = {"climby_eye_vine.png"},
	-- inventory_image = "default_papyrus.png",
	-- wield_image = "climby_eye_vine.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
	},
	groups = {snappy = 3, flammable = 2, hive = 1},
	sounds = default.node_sound_leaves_defaults(),

	after_dig_node = function(pos, node, metadata, digger)
		default.dig_up(pos, node, digger)
	end,
    climbable = true,
})



local function grow_vine(pos, node)
	pos.y = pos.y - 1
	local name = minetest.get_node(pos).name
	-- if name ~= "default:dirt" and
	-- 		name ~= "default:dirt_with_grass" and
	-- 		name ~= "default:dirt_with_dry_grass" and
	-- 		name ~= "default:dirt_with_rainforest_litter" and
	-- 		name ~= "default:dry_dirt" and
	-- 		name ~= "default:dry_dirt_with_dry_grass" then
	-- 	return
	-- end
	-- if not minetest.find_node_near(pos, 3, {"group:water"}) then
	-- 	return
	-- end
	pos.y = pos.y + 1
	local height = 0
	while node.name == "fh:vine" and height < 40 do
		height = height + 1
		pos.y = pos.y + 1
		node = minetest.get_node(pos)
	end
	-- if height == 40 or node.name ~= "air" then
	-- 	return
	-- end
	-- if minetest.get_node_light(pos) < 13 then
	-- 	return
	-- end
	minetest.set_node(pos, {name = "fh:vine"})
	return true
end


minetest.register_abm({
	label = "Grow vine",
	nodenames = {"fh:vine"},
	-- Grows on the dirt and surface dirt nodes of the biomes papyrus appears in,
	-- including the old savanna nodes.
	-- 'default:dirt_with_grass' is here only because it was allowed before.
	neighbors = {
		"group:hive"
    },
	interval = 14,
	chance = 1,
	action = function(...)
		grow_vine(...)
	end
})

