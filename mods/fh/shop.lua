-- player shop uwu

local S = default.get_translator
local mod_def = minetest.get_modpath("default")

-- GUI elements are accessible with flow.widgets. Using
-- `local gui = flow.widgets` is recommended to reduce typing.
local gui = flow.widgets

local hive_gui  = nil
-- GUIs are created with flow.make_gui(build_func).
hive_gui = flow.make_gui(function(_player, _ctx)
    -- The build function should return a GUI element such as gui.VBox.
    -- `ctx` can be used to store context. `ctx.form` is reserved for storing
    -- the state of elements in the form. For example, you can use
    -- `ctx.form.my_checkbox` to check whether `my_checkbox` is checked. Note
    -- that ctx.form.element may be nil instead of its default value.

    -- This function may be called at any time by flow.

    -- gui.VBox is a "container element" added by this mod.

    local shop_ui = {
        name = "forge_gui",
        h = 10,
        w = 10,

    }

    -- ScrollContainer
    for name, v in pairs(fh.settings.shop_survivor) do
        shop_ui[#shop_ui + 1] = gui.ItemImageButton {
            w = 1, h= 1,
            name = name,
            item_name = v.name,
            label = v.cost .. " biomass",
            on_event = function(player, ctx)
                local biomass = player:get_meta():get_int(fh.keys.biomass)
                if biomass >= v.cost then
                    local item_stack = ItemStack(v.name)
                    item_stack:set_count(1)
                    player:get_inventory():add_item("main", item_stack)
                    player:get_meta():set_int(fh.keys.biomass, biomass - v.cost)
                end
            end,
        }
    end

    return gui.VBox{
        gui.Label {label = "Hive"},
    gui.ButtonExit{label = "Close"},
    -- gui.Dropdown {
    --     -- The value of this dropdown will be accessible from ctx.form.my_dropdown
    --     name = "my_dropdown",
    --     items = {'First item', 'Second item', 'Third item'},
    --     index_event = true,
    -- },
    -- gui.Button {
    --     label = "Get dropdown index",
    --     on_event = function(player, ctx)
    --         -- flow should guarantee that `ctx.form.my_dropdown` exists, even if the client doesn't send my_dropdown to the server.
    --         local selected_idx = ctx.form.my_dropdown
    --         minetest.chat_send_player(player:get_player_name(), "You have selected item #" .. selected_idx .. "!")
    --     end,
    -- },
    gui.Button {
        label = "Set as home hive",
        on_event = function(player, ctx)
            local name = player:get_player_name()
            local pos = player:get_pos()
            beds.spawn[name] = pos
            beds.set_spawns()
        end,
    },
    gui.ScrollableVBox(shop_ui)
}
end)

minetest.register_node("fh:forge", {
	description = "forge",
    tiles = {"market_vertical.png", "market_vertical.png", "market.png"},
	is_ground_content = false,
	groups = {},
	drop = {
		items = {
			{items = {"fh:fragment"}, min = 1, max = 3},
		}
	},
	on_rightclick = function(pos, node, player, itemstack, pointed_thing)
        if fh.class_is_survivor(player) then
		hive_gui:show(player)
        end

	end,
	light_source = minetest.LIGHT_MAX,
	sounds = default.node_sound_metal_defaults(),
})

