local modname = minetest.get_current_modname()
local path = minetest.get_modpath(modname)
local S = default.get_translator



function mobs:register_egg(mob, desc, background, addegg, no_creative)

	local grp = {spawn_egg = 1}

	-- do NOT add this egg to creative inventory (e.g. dungeon master)
	if no_creative == true then
		grp.not_in_creative_inventory = 1
	end

	local invimg = background

	if addegg == 1 then
		invimg = "mobs_chicken_egg.png^(" .. invimg ..
			"^[mask:mobs_chicken_egg_overlay.png)"
	end

	-- register new spawn egg containing mob information
	minetest.register_craftitem(mob .. "_set", {

		description = S("@1 (Tamed)", desc),
		inventory_image = invimg,
		groups = {spawn_egg = 2, not_in_creative_inventory = 1},
		stack_max = 1,

		on_place = function(itemstack, placer, pointed_thing)

			local pos = pointed_thing.above

			-- does existing on_rightclick function exist?
			local under = minetest.get_node(pointed_thing.under)
			local def = minetest.registered_nodes[under.name]

			if def and def.on_rightclick then

				return def.on_rightclick(
						pointed_thing.under, under, placer, itemstack, pointed_thing)
			end

			if pos then

				if not minetest.registered_entities[mob] then
					return
				end

				pos.y = pos.y + 1

				local data = itemstack:get_metadata()
				local smob = minetest.add_entity(pos, mob, data)
				local ent = smob and smob:get_luaentity()

				if not ent then return end -- sanity check

				-- set owner if not a monster
				if ent.type ~= "monster" then
					ent.owner = placer:get_player_name()
					ent.tamed = true
				end

				-- since mob is unique we remove egg once spawned
				itemstack:take_item()
			end

			return itemstack
		end
	})


	-- register old stackable mob egg
	minetest.register_craftitem(mob, {

		description = desc,
		inventory_image = invimg,
		groups = grp,

		on_place = function(itemstack, placer, pointed_thing)

			local pos = pointed_thing.above

			-- does existing on_rightclick function exist?
			local under = minetest.get_node(pointed_thing.under)
			local def = minetest.registered_nodes[under.name]

			if def and def.on_rightclick then

				return def.on_rightclick(
						pointed_thing.under, under, placer, itemstack, pointed_thing)
			end

			if pos then

				if not minetest.registered_entities[mob] then
					return
				end

				-- have we reached active mob limit
				-- if active_limit > 0 and active_mobs >= active_limit then
				-- 	minetest.chat_send_player(placer:get_player_name(),
				-- 			S("Active Mob Limit Reached!")
				-- 			.. "  (" .. active_mobs
				-- 			.. " / " .. active_limit .. ")")
				-- 	return
				-- end

				pos.y = pos.y + 1

				local smob = minetest.add_entity(pos, mob)
				local ent = smob and smob:get_luaentity()

				if not ent then return end -- sanity check

				-- don't set owner if monster or sneak pressed
				if ent.type ~= "monster"
				and not placer:get_player_control().sneak then
					ent.owner = placer:get_player_name()
					ent.tamed = true
				end

				-- if not in creative then take item
				if not mobs.is_creative(placer:get_player_name()) then
					itemstack:take_item()
				end
			end

			return itemstack
		end
	})
end



mobs:alias_mob("fh:tank", "lh_mobs:dungeon_master")

mobs:register_egg("fh:tank", S("Tank"), "fire_basic_flame.png", 1)

dofile(path .. "/mob_spore.lua")