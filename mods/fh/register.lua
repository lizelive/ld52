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
        local formspec = "size[8,9]" ..
        "label[0,0;Buy and Sell Blocks]" ..
        "list[current_player;main;0,1;8,4;]" ..
        "button[0,5;4,1;buy;Buy]" ..
        "button[4,5;4,1;sell;Sell]" ..
        "list[npc;sell;0,6;8,3;]"

        -- fs(formspec)
		fs("label", 3, 1, "Just a test")
        fs"button[0,5;4,1;buy;Buy Spore (1000)]"
		fs"label[3,2;Lorem Ipsum]"
		-- No need to return anything
	end,

	-- Events handling happens here
	fields = function(player, data, fields)
		if fields.buy then
			-- Do things
            minetest.debug("buy buy buy")
		end

		i3.set_fs(player) -- Update the formspec, mandatory
	end,
})