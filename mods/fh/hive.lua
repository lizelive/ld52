
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
        name = "hive_gui",
        h = 10,
        w = 10,

    }

    -- ScrollContainer
    for name, v in pairs(fh.settings.shop) do
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

minetest.register_node("fh:heart", {
	description = "heart",
	drawtype = "mesh",
	mesh = "heart.obj",
	tiles = {"biomass.png", "alien_metal.png"},
	is_ground_content = false,
	groups = {cracky = 1, level = 3, hive = 1},
	drop = {
		items = {
			{items = {"fh:fragment"}, min = 1, max = 3},
		}
	},
	on_rightclick = function(pos, node, player, itemstack, pointed_thing)
        if not fh.class_is_survivor(player) then
		hive_gui:show(player)
        end

	end,
	light_source = minetest.LIGHT_MAX,
	sounds = default.node_sound_metal_defaults(),
})



minetest.register_node("fh:tendril", {
	description = "tendril",
	tiles = {"tendril_top.png", "tendril_top.png", "tendril.png"},
	groups = {choppy = 1, flammable = 1, hive = 1, log = 1, wood = 1},
	sounds = mod_def and default.node_sound_leaves_defaults(),
	on_place = minetest.rotate_node,
	paramtype2 = "facedir",
})


minetest.register_node("fh:piller", {
	description = S("piller"),
	drawtype = "allfaces_optional",
	waving = 1,
	tiles = {"alien_corruption.png"},
	-- special_tiles = {"biomass.png"},
	paramtype = "light",
	is_ground_content = false,
	groups = {fleshy = 1, leafdecay = 3, flammable = 2, leaves = 1, hive = 1, falling_node = 1, dig_immediate = 3},
	-- drop = "",
    on_timer = function(pos, elapsed)
        local above = vector.offset(pos, 0, 1, 0)
        minetest.remove_node(pos)
        minetest.check_for_falling(above)
    end,
	sounds = default.node_sound_leaves_defaults(),
    on_construct = function(pos)
        minetest.get_node_timer(pos):start(0.1)
    end,
    after_place_node = function(pos, placer, itemstack, pointed_thing)
        minetest.get_node_timer(pos):start(3)
    end,
	-- after_place_node = default.after_place_leaves,
})



minetest.register_node("fh:trickle", {
	description = S("trickles"),
	drawtype = "allfaces_optional",
	waving = 1,
	tiles = {"alien_corruption.png"},
	-- special_tiles = {"biomass.png"},
	paramtype = "light",
	is_ground_content = false,
	groups = {fleshy = 3, leafdecay = 3, flammable = 2, leaves = 1, hive = 1},
	drop = {
		max_items = 1,
		items = {
			{
				-- player will get sapling with 1/20 chance
				items = {"fh:alien_egg"},
				rarity = 20,
			},
			{
				-- player will get leaves only if he get no saplings,
				-- this is because max_items is 1
				items = {"fh:trickle"},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),

	-- after_place_node = default.after_place_leaves,
})

default.register_leafdecay({
    trunks = {"fh:tendril"},
    leaves = {"fh:trickle"},
    radius = 2,
})