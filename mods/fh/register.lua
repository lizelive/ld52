local modname = minetest.get_current_modname()
local path = minetest.get_modpath(modname)
local S = default.get_translator

update_timer = 0
local update_timer_step = 0.1

minetest.register_globalstep(function(dtime)
    update_timer = update_timer + dtime
    if update_timer >= update_timer_step then
        -- minetest.debug("so " .. update_timer)
        fh.step(dtime)
        for _, player in ipairs(minetest.get_connected_players()) do
            fh.step_player(player, dtime)
        end
        update_timer = 0
    end
end)

minetest.register_on_joinplayer(function(player, last_login)
    fh.fix_player_nametag(player, last_login)
    fh.setup_hudbar(player, last_login)
    fh.class_become(player, last_login)
end)



-- nice

i3.new_tab("scyther", {
	description = "scyther shop",
	image = "eat_tool.png", -- Optional, add an image next to the tab description

	--
	-- The functions below are all optional
	--

	-- Determine if the tab is visible by a player, return false to hide the tab
	access = function(player, data)
		-- local name = player:get_player_name()
        return not fh.class_is_survivor(player)
		-- return name == "singleplayer"
	end,

	formspec = function(player, data, fs)
		fs("label", 1, 1, "Harvester Shop")
        local i = 0
        for name, v in pairs(fh.settings.shop) do
            fs("item_image_button", 0, 1 + i, 2, 2, v.name, "buy_" .. name, v.cost .. " biomass")
            i = i + 2
        end
        
		fs"label[3,2;Lorem Ipsum]"
		-- No need to return anything
	end,

	-- Events handling happens here
	fields = function(player, data, fields)
        for name, v in pairs(fh.settings.shop) do
            if fields["buy_" .. name] then
                local biomass = player:get_meta():get_int(fh.keys.biomass)
                if biomass >= v.cost then
                    local item_stack = ItemStack(v.name)
                    item_stack:set_count(1)
                    player:get_inventory():add_item("main", item_stack)
                    player:get_meta():set_int(fh.keys.biomass, biomass - v.cost)
                end
            end
        end
		i3.set_fs(player) -- Update the formspec, mandatory
	end,
})