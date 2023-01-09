local modname = minetest.get_current_modname()
local path = minetest.get_modpath(modname)
local S = default.get_translator

function lh_player.update_scyther(player, dtime)
    local player_name = player:get_player_name()
    local meta = player:get_meta()
    if not lh_player.class_is_scyther(player) then
        return
    end
    -- look for nearby blocks to recharge harvest

    -- lock fist 3 items in hotbar

    -- slight biomass passive regen for being around a lot of corruption
    -- buffs for long term coruption
end

-- do a consume
-- costs 10 harvest
function lh_player.consume(player, dtime)
    -- remove some harvest
    -- adds biomass
end

-- summon tank - 1000 bop,ass
-- summon tank - 1000
