local modname = minetest.get_current_modname()
local path = minetest.get_modpath(modname)
local S = default.get_translator

fh.class_survivor = 0
fh.class_scyther = 1

function fh.class_get(player)
    return player:get_meta():get_int(fh.keys.class)
end
function fh.class_set(player, class)
    return player:get_meta():set_int(fh.keys.class, class)
end

function fh.class_is_survivor(player)
    return fh.class_get(player) == fh.class_survivor
end

-- can be called as much as you want without causing problems
local function become_survivor(player)
    player_api.set_textures(player, {"player_survivor.png"})
    hb.hide_hudbar(player, fh.keys.biomass)
    hb.hide_hudbar(player, fh.keys.harvest)
end

-- can be called as much as you want without causing problems
local function become_scyther(player)
    player_api.set_textures(player, {"player_scyther.png"})
    hb.unhide_hudbar(player, fh.keys.biomass)
    hb.unhide_hudbar(player, fh.keys.harvest)
end



function fh.class_become(player)
    if not fh.class_is_survivor(player) then
        become_scyther(player)
    else
        become_survivor(player)
    end
    fh.fix_player_nametag(player)
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
        meta:set_int(fh.keys.biomass, fh.settings.start_biomass)
        meta:set_int(fh.keys.harvest, fh.settings.start_harvest)
        fh.class_set(player, fh.class_scyther)
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

    if fh.class_is_survivor(player) then
        local msg = name .. " has been harvested"
        minetest.chat_send_all(msg)
    end
    -- oh it's your first death. congrats
    


    meta:set_int(fh.keys.biomass, fh.settings.start_biomass)
    meta:set_int(fh.keys.harvest, fh.settings.start_harvest)
    fh.class_set(player, fh.class_scyther)
    fh.class_become(player)
    -- fix the player nametag
end)
