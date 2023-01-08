hb.register_hudbar(lh_player.keys.harvest, '0xFFFFFF', S('harvest'), {
    bar = "lh_harvest_bar.png",
    icon = "lh_harvest_icon.png"
}, 0, lh_player.settings.max_harvest, true)


hb.register_hudbar(lh_player.keys.biomass, '0xFFFFFF', S('biomass'), {
    bar = "lh_biomass_bar.png",
    icon = "lh_biomass_icon.png"
}, 0, lh_player.settings.max_biomass, true)

minetest.register_on_joinplayer(function(player)
    hb.init_hudbar(player, lh_player.keys.biomass, 0, lh_player.settings.max_biomass, true)
    hb.init_hudbar(player, lh_player.keys.harvest, 0, lh_player.settings.max_harvest, true)
end)
