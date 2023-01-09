commoditymarket.register_market("market", {
    description = "Market",
    currency = {["lh_items:alien_fragment"] = 1},
    inventory_limit = 1000,
    sell_limit = 100,
    initial_items = {"default:apple", "farming:bread",
                     "default:sword_wood", "default:sword_stone"},
    allow_item = function(item) return true end,
    anonymous = true
})

minetest.register_node("market:market", {
    description = "Market",
    tiles = {"market_vertical.png", "market_vertical.png", "market.png"},
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        assert(clicker ~= nil)
        if not clicker:is_player() then
            return
        end
        commoditymarket.show_market("market", clicker:get_player_name())
    end
})

minetest.register_decoration({
    deco_type = "simple",
    place_on = {"default:dirt_with_grass", "default:sand"},
    sidelen = 16,
    fill_ratio = 0.001,
    y_max = 200,
    y_min = -50,
    decoration = "market:market"
})
