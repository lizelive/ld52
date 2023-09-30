local settings = {
    max_biomass = 9001,
    start_biomass = 500,
    max_harvest = 100,
    start_harvest = 50,
    biomass_per_health = 10,
    biomass_per_hunger = 10,
    hunger_per_tick = 0.0002,
    shop = {
        consume = {name = "fh:consume", cost = 100},
        tank = {name = "lh_mobs:dungeon_master", cost = 1000},
        spore = {name = "fh:spore", cost = 100},
        chiten = {name = "fh:chiten", cost = 10},
        biomass = {name = "fh:biomass", cost = 2},
        vine = {name = "fh:vine", cost = 500},
        comb = {name = "fh:comb", cost = 500},
        heart = {name = "fh:heart", cost = 5000},
        polyp = {name = "fh:polyp", cost = 50},
        -- scythe = {name = "fh:scythe", cost = 5000},
    },
    shop_survivor = {
        sword_bronze = { name = "default:sword_bronze", cost = 100},
        sword_steel = { name = "default:sword_steel", cost = 300},
        rocket_tube_loaded = { name = "splooshy_bombs_rpg:rocket_tube_loaded", cost = 1000},
    },
    safezone_radius = 20,
    safezone_duration = 5 * 24 * 60 * 60,
}
return settings
