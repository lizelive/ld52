
local S = mobs.intllib_monster



-- Tree Monster (or Tree Gollum) by PilzAdam

mobs:register_mob("fh:spore", {
	type = "monster",
	passive = false,
	attack_type = "dogfight",
	attack_animals = true,
    attack_players = true,
    attack_chance = 80,
	--specific_attack = {"player", "mobs_animal:chicken"},
	reach = 2,
	damage = 2,
	hp_min = 10,
	hp_max = 20,
	armor = 100,
	collisionbox = {-0.4, -1, -0.4, 0.4, 0.8, 0.4},
	visual = "mesh",
	mesh = "mobs_spore.b3d",
	textures = {
		{"mobs_spore.png"},
	},
	blood_texture = "spore.png",
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_treemonster"
	},
	walk_velocity = 1,
	run_velocity = 3,
    replace_what = {"group:organic"},
    replace_with = "fh:biomass",
    replace_rate = 10,
    on_replace = function(self, pos, oldnode, newnode)
        minetest.debug("on_replace called pos="..minetest.pos_to_string(pos) .. "owner= ".. self.owner)
    end,
	jump = true,
	view_range = 40,
	drops = {
		{name = "fh:fragment", chance = 1, min = 4, max = 10},
		{name = "fh:scrap", chance = 1, min = 0, max = 1},
		{name = "fh:biomass", chance = 1, min = 5, max = 10},
	},
	water_damage = 0,
	lava_damage = 0,
	light_damage = 2,
	fall_damage = 0,
	immune_to = {
		{"default:axe_wood", 0}, -- wooden axe doesnt hurt wooden monster
		{"default:axe_stone", 4}, -- axes deal more damage to tree monster
		{"default:axe_bronze", 5},
		{"default:axe_steel", 5},
		{"default:axe_mese", 7},
		{"default:axe_diamond", 9},
		{"default:sapling", -5}, -- default and jungle saplings heal
		{"default:junglesapling", -5},
--		{"all", 0}, -- only weapons on list deal damage
	},
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 24,
		walk_start = 25,
		walk_end = 47,
		run_start = 48,
		run_end = 62,
		punch_start = 48,
		punch_end = 62
	},

	-- check surrounding nodes and spawn a specific tree monster
	-- on_spawn = function(self)
    --     --
	-- 	return true -- run only once, false/nil runs every activation
	-- end
})


if not mobs.custom_spawn_monster then

	mobs:spawn({
		name = "fh:spore",
		nodes = {"group:hive"},
		max_light = 7,
		chance = 7000,
		min_height = 0,
		day_toggle = false
	})
end


mobs:register_egg("fh:spore", S("Spore"), "spore.png", false)

