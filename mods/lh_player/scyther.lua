local modname = minetest.get_current_modname()
local path = minetest.get_modpath(modname)
local S = default.get_translator

function lh_player.update_scyther(player, dtime)
    -- look for nearby blocks to recharge harvest

    -- lock fist 3 items in hotbar

    -- slight biomass passive regen for being around a lot of corruption
    -- buffs for long term coruption
end

local function update_waypoints(player, dtime)
    local player_name = player:get_player_name()
    for _, waypoint in ipairs(i3.get_waypoints(player_name)) do
        i3.add_waypoint("food", {
            player = "singleplayer",
            pos = {x = 0, y = 2, z = 0},
            color = 0xffff00
            --	image = "heart.png" (optional)
        })
    end
end

-- do a consume
-- costs 10 harvest
function lh_player.consume(player, dtime)
    -- remove some harvest
    -- adds biomass
end

-- summon tank - 1000 bop,ass
-- summon tank - 1000
