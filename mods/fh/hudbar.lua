local modname = minetest.get_current_modname()
local path = minetest.get_modpath(modname)
local S = default.get_translator

hb.register_hudbar(fh.keys.harvest, '0xFFFFFF', S('harvest'),
                   {bar = "lh_harvest_bar.png", icon = "lh_harvest_icon.png"},
                   0, fh.settings.max_harvest, true)

hb.register_hudbar(fh.keys.biomass, '0xFFFFFF', S('biomass'),
                   {bar = "lh_biomass_bar.png", icon = "lh_biomass_icon.png"},
                   0, fh.settings.max_biomass, true)

function fh.setup_hudbar(player)
    hb.init_hudbar(player, fh.keys.biomass, 0,
                   fh.settings.max_biomass, true)
    hb.init_hudbar(player, fh.keys.harvest, 0,
                   fh.settings.max_harvest, true)
end

