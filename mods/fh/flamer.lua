local modname = minetest.get_current_modname()
local path = minetest.get_modpath(modname)
local S = default.get_translator

minetest.register_tool("fh:flamer", {
	description = S("Flamer"),
	inventory_image = "flamer.png",
	sound = {breaks = "default_tool_breaks"},
    range = 100,
	on_use = function(itemstack, user, pointed_thing)
        local hit_pos = nil

        local player = user
        local player_name = user:get_player_name()
        local dir = player:get_look_dir()
        local head_pos = vector.add(player:getpos(),{x=0,y=1.6,z=0}) + dir
        local distance = 100

        if pointed_thing then
            hit_pos = pointed_thing.under
        end
        -- if not hit_pos then
        --     local raycast = minetest.raycast(pos, dir, distance)
        --     local pointed_thing = raycast:next()
        --     hit_pos = (pointed_thing.intersection_point  + dir)
        --     minetest.debug(dump(pointed_thing))
        -- end
        local sound_pos = pointed_thing.above or user:get_pos()
		minetest.sound_play("fire_flint_and_steel",
			{pos = sound_pos, gain = 0.2, max_hear_distance = 8}, true)


        -- spawn cone of fire
        minetest.add_particlespawner(
            {
                time = 0.1,
                radius = 1,
                jitter = 1,
                drag = 0.1,
                pos = head_pos,
                amount = 100,
                vertical = true,
                texture = "fire_basic_flame.png",
                vel = dir * 10,
                collision_removal = true,
                collisiondetection = true,
                glow = 14
            })

		if hit_pos then
			local node_under = minetest.get_node(hit_pos).name

			local nodedef = minetest.registered_nodes[node_under]
			if not nodedef then
				return
			end
			if minetest.is_protected(pointed_thing.under, player_name) then
				minetest.chat_send_player(player_name, "This area is protected")
				return
			end

            if nodedef.on_ignite then
				nodedef.on_ignite(pointed_thing.under, user)
			elseif minetest.get_item_group(node_under, "flammable") >= 1
					and minetest.get_node(pointed_thing.above).name == "air" then
				minetest.set_node(pointed_thing.above, {name = "fire:basic_flame"})
            elseif minetest.get_item_group(node_under, "grass") ==1 then
                minetest.env:set_node(pointed_thing.under, {name="fh:dirt_with_scorched_grass"})
            end
		end
		if not minetest.is_creative_enabled(player_name) then
			-- Wear tool
			local wdef = itemstack:get_definition()
			itemstack:add_wear_by_uses(66)

			-- Tool break sound
			if itemstack:get_count() == 0 and wdef.sound and wdef.sound.breaks then
				minetest.sound_play(wdef.sound.breaks,
					{pos = sound_pos, gain = 0.5}, true)
			end
			return itemstack
		end
	end
})

minetest.register_node("fh:dirt_with_scorched_grass", {
	description = S("Dirt with Grass"),
	tiles = {"default_grass.png^[multiply:#555", "default_dirt.png",
		{name = "default_dirt.png^(default_grass_side.png^[multiply:#555)",
			tileable_vertical = false}},
    -- todo should prob be a soil?
	groups = {crumbly = 3},
	drop = "default:dirt",
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_grass_footstep", gain = 0.25},
	}),
})

minetest.register_craft({
	output = "tnt:tnt_stick",
	recipe = {{"fh:jelly"}}
  })

minetest.register_craft({
	output = "fh:flamer",
	recipe = {
		{"fh:jelly", "fh:fragment", "fh:jelly"}
	}
})

minetest.register_craft({
	output = "fh:flamer",
	recipe = {
		{"fh:jelly", "fh:fragment", "fh:jelly"}
	}
})

-- -- Override coalblock to enable permanent flame above
-- -- Coalblock is non-flammable to avoid unwanted basic_flame nodes
-- minetest.override_item("default:coalblock", {
-- 	after_destruct = function(pos)
-- 		pos.y = pos.y + 1
-- 		if minetest.get_node(pos).name == "fire:permanent_flame" then
-- 			minetest.remove_node(pos)
-- 		end
-- 	end,
-- 	on_ignite = function(pos)
-- 		local flame_pos = {x = pos.x, y = pos.y + 1, z = pos.z}
-- 		if minetest.get_node(flame_pos).name == "air" then
-- 			minetest.set_node(flame_pos, {name = "fire:permanent_flame"})
-- 		end
-- 	end
-- })