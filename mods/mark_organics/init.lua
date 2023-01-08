minetest.debug("i eat people")

local S = default.get_translator

local target_absorb_from_mob = 10

local organic_groups = {
    "fleshy", "meat", "eatable", "flora", "grass", "leaves", "spreading_dirt_type"
}




local organic_nodes = {"default:papyrus", "default:junglegrass"}

-- local function shallowCopy(original)
--     local copy = {}
--     for key, value in pairs(original) do
--       copy[key] = value
--     end
--     return copy
--   end


local function shallow_copy(original)
    local copy = {}
    for key, value in pairs(original) do
      copy[key] = value
    end
    return copy
end


for node_name, node in pairs(minetest.registered_nodes) do
    local is_organic = false
    for _,group in pairs(organic_groups) do
        if node.groups[group] then
            is_organic = true
            break
        end
    end
    if node.groups["hive"] == 1 then
        is_organic = false
    end
    if is_organic then
        -- minetest.debug(node_name .. " is organic")
        local groups = shallow_copy(node.groups)
        groups["organic"]=1
        minetest.debug(dump(groups))
        -- local groups = { organic=1}
        minetest.override_item(node.name, {groups=groups})
    end
end


-- for node_name, node in pairs(minetest.registered_nodes) do
--     if node.groups["organic"] then
--         minetest.debug("i ate " .. node_name .. " and its " .. dump(node))
--     end
-- end

local function grass_to_dirt(pos1, pos2)
    local c_dirt  = minetest.get_content_id("default:dirt")
    local c_grass = minetest.get_content_id("default:dirt_with_grass")

    -- Read data into LVM
    local vm = minetest.get_voxel_manip()
    local emin, emax = vm:read_from_map(pos1, pos2)
    local a = VoxelArea:new{
        MinEdge = emin,
        MaxEdge = emax
    }
    local data = vm:get_data()

    -- Modify data
    for z = pos1.z, pos2.z do
        for y = pos1.y, pos2.y do
            for x = pos1.x, pos2.x do
                local vi = a:index(x, y, z)
                if data[vi] == c_grass then
                    data[vi] = c_dirt
                end
            end
        end
    end

    -- Write data
    vm:set_data(data)
    vm:write_to_map(true)
end


local absorb_tool_capabilities = {
    full_punch_interval = 0.8,
    damage_groups = { fleshy = 5, choppy = 10 },

    -- This is only used for digging nodes, but is still required
    max_drop_level=1,
    groupcaps={
        fleshy={times={[1]=2.5, [2]=1.20, [3]=0.35}, uses=30, maxlevel=2},
    },
}

local function absorb(user, pos)
    local pos1       = vector.subtract(pos, { x = 5, y = 5, z = 5 })
    local pos2       = vector.add(pos, { x = 5, y = 5, z = 5 })
    local pos_list   = minetest.find_nodes_in_area(pos1, pos2, { "group:organic" })
    
    -- minetest.debug("absorb = " .. dump(pos_list))


    points_earned = 0

    for i=1, #pos_list do
        -- todo totally remove air blocks
        minetest.swap_node(pos_list[i], { name = "alien_blocks:dirt_with_alien_grass" })
        points_earned = points_earned  + 1
    end


    local obj_list = minetest.get_objects_in_area(pos1, pos2)
    for _,obj in pairs(obj_list) do
        if obj == user then
            break
        end
        local hp = obj:get_hp()
        -- local new_hp = math.max(0, hp - 10)
        -- obj:set_hp(new_hp)
        local new_hp = obj:get_hp()
        local damge_done = hp - new_hp
        points_earned = points_earned + damge_done 
        -- obj:get_entity_name() 
        minetest.debug("i eat people " .. (obj:get_player_name() or obj:get_entity_name() or "other")  .. " and i did " ..  damge_done  )
        obj:punch(user, nil, absorb_tool_capabilities)
    end

    minetest.debug("i ate " .. points_earned)    
end




minetest.register_chatcommand("echo", {
    privs = {
        interact = true,
    },
    func = function(name, param)
        return true, "You said " .. param .. "!"
    end,
})


minetest.register_tool("mark_organics:eat_tool", {
    description = "Nom nom",
    inventory_image = "eat_tool.png",
    tool_capabilities = {
        full_punch_interval = 1.5,
        max_drop_level = 1,
        groupcaps = {
            crumbly = {
                maxlevel = 2,
                uses = 20,
                times = { [1]=1.60, [2]=1.20, [3]=0.80 }
            },
        },
        damage_groups = {fleshy=2},
    },
    
    on_use = function(itemstack, user, pointed_thing)
        local pos = pointed_thing.under or user:get_pos()
        -- minetest.debug(dump(user))
        if pos then
            absorb(user, pos)
        end
    end,
    -- default: nil
    -- When user pressed the 'punch/mine' key with the item in hand.
    -- Function must return either nil if inventory shall not be modified,
    -- or an itemstack to replace the original itemstack.
    -- e.g. itemstack:take_item(); return itemstack
    -- Otherwise, the function is free to do what it wants.
    -- The user may be any ObjectRef or nil.
    -- The default functions handle regular use cases.
})

local bar_id = "barofpain"
hb.register_hudbar(
    bar_id,
    '0xFFFFFF',
    S('harvest'),
    {
        bar = "scyther_harvest_bar.png",
        icon = "scyther_harvest_icon.png"
    },
    100,
    1000,
    false
)


minetest.register_on_joinplayer(function(player)
    hb.init_hudbar(player, bar_id, 20, 20, false)
  end)
  