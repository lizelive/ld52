local S = default.get_translator

mobs:alias_mob("scyther_mobs:tank", "mobs_monster:dungeon_master")
mobs:alias_mob("scyther_mobs:spore", "mobs_monster:tree_monster")


mobs:register_egg("scyther_mobs:tank", S("Tank"), "fire_basic_flame.png", 2, false)
mobs:register_egg("scyther_mobs:spore", S("Spore"), "flowers_mushroom_red.png", 2, false)

-- /grantme all
-- /giveme scyther_mobs:spore