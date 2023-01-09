local modname = minetest.get_current_modname()
local path = minetest.get_modpath(modname)
local S = default.get_translator

lh_player.class_survivor = 0
lh_player.class_scyther = 1

function lh_player.class_get(player)
    return player:get_meta():get_int(lh_player.keys.class)
end
function lh_player.class_set(player, class)
    return player:get_meta():set_int(lh_player.keys.class, class)
end

function lh_player.class_is_survivor(player)
    return lh_player.class_get(player) == lh_player.class_survivor
end

-- can be called as much as you want without causing problems
local function become_survivor(player)
    player_api.set_textures(player, {"player_survivor.png"})
    hb.hide_hudbar(player, lh_player.keys.biomass)
    hb.hide_hudbar(player, lh_player.keys.harvest)
end

-- can be called as much as you want without causing problems
local function become_scyther(player)
    player_api.set_textures(player, {"player_scyther.png"})
    hb.unhide_hudbar(player, lh_player.keys.biomass)
    hb.unhide_hudbar(player, lh_player.keys.harvest)
end



function lh_player.class_become(player)
    if not lh_player.class_is_survivor(player) then
        become_scyther(player)
    else
        become_survivor(player)
    end
    lh_player.fix_player_nametag(player)
end

-- local function change_to_scyther

minetest.register_chatcommand("become_scyther", {
    params = "",
    privs = {
        -- server=true
    },

    description = S("become a scyther"),
    func = function(player_name, _)
        -- entity_modifier.disguise_to_model(player_name, "lh_mobs:tank", nil)
        local player = minetest.get_player_by_name(player_name)
        
        local meta = player:get_meta()
        meta:set_int(lh_player.keys.biomass, lh_player.settings.start_biomass)
        meta:set_int(lh_player.keys.harvest, lh_player.settings.start_harvest)
        lh_player.class_set(player, lh_player.class_scyther)
        become_scyther(player)
        -- "player_back.png"
    end
})

-- nuke area
-- minetest.delete_area(pos1, pos2)

-- minetest.clear_registered_biomes()

-- player_api.set_textures(player, textures)



minetest.register_on_dieplayer(function(player)
    -- todo: convert human score to alien biomass
    
    local meta = player:get_meta()
    local name = player:get_player_name()

    if lh_player.class_is_survivor(player) then
        local msg = name .. " has been harvested"
        minetest.chat_send_all(msg)
    end
    -- oh it's your first death. congrats
    


    meta:set_int(lh_player.keys.biomass, lh_player.settings.start_biomass)
    meta:set_int(lh_player.keys.harvest, lh_player.settings.start_harvest)
    lh_player.class_set(player, lh_player.class_scyther)
    lh_player.class_become(player)
    -- fix the player nametag
end)
