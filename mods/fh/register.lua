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


local function findspawn(player, spawn, radius)
    local pos = {x = spawn.x, y = spawn.y, z = spawn.z}
    pos.x = spawn.x + math.random(-radius, radius)
    pos.y = spawn.y
    pos.z = spawn.z + math.random(-radius, radius)
    for try=100, 0, -1 do
		local pos = {x = spawn.x, y = spawn.y, z = spawn.z}
		pos.x = spawn.x + math.random(-radius, radius)
		pos.y = spawn.y
		pos.z = spawn.z + math.random(-radius, radius)
        local free = pos
		minetest.forceload_block(free, true)
		-- Find ground level
		local ground_y = nil
		for y=128, -128, -1 do
			local nn = minetest.get_node({x=pos.x, y=pos.y+y, z=pos.z}).name
			if nn ~= "air" and nn ~= "ignore" then
				ground_y = pos.y+y
				break
			end
		end
		if ground_y then
			pos.y = ground_y
			if 
                minetest.registered_nodes[minetest.get_node(pos).name].walkable == true and
				minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name == "air" and
				minetest.get_node({x=pos.x, y=pos.y+2, z=pos.z}).name == "air" then
				local pos_spawn = {x=pos.x, y=pos.y+1, z=pos.z}
				return pos_spawn
			end
		end
		minetest.forceload_free_block(free, true)
	end
end


local spawn = vector.new(0,0,0)

local function spawnarea(player)
	local pos = findspawn(player, spawn, 250)
	if pos then
		player:set_pos(pos)
	else
		player:set_pos(spawn)
	end
end

-- if not minetest.is_singleplayer() then
minetest.register_on_newplayer(function(player)
    minetest.debug("idk player joined?")
	-- spawnarea(player)
end)
-- end

minetest.register_on_joinplayer(function(player, last_login)
    local meta = player:get_meta()
    -- local returning = meta:get_bool("returning")
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
        local size = 1
        for name, v in pairs(fh.settings.shop) do
            fs("item_image_button", 0, 1 + i, size, size, v.name, "buy_" .. name, v.cost .. " biomass")
            i = i + size
        end
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