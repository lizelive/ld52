minetest.debug("i eat people")


local organic_groups = {
    "fleshy", "meat", "eatable", "flora", "grass", "leaves", "spreading_dirt_type"
}


local organic_nodes = {"default:papyrus", "default:junglegrass"}

for node_name, node in pairs(minetest.registered_nodes) do
    local is_organic = false
    for _,group in pairs(organic_groups) do
        if node.groups[group] then
            is_organic = true
            break
        end
    end
    if is_organic then
        minetest.debug(node_name .. " is organic")
        local groups = { unpack(node.groups), organic=1}
        -- local groups = { organic=1}
        minetest.override_item(node.name, {groups=groups})
    end
end


for node_name, node in pairs(minetest.registered_nodes) do
    if node.groups["organic"] then
        minetest.debug("i ate " .. node_name .. " and its " .. dump(node))
    end
end

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



local function absorb(pos)
    local pos1       = vector.subtract(pos, { x = 5, y = 5, z = 5 })
    local pos2       = vector.add(pos, { x = 5, y = 5, z = 5 })
    local pos_list   = minetest.find_nodes_in_area(pos1, pos2, { "group:organic" })
    
    minetest.debug("absorb = " .. dump(pos_list))

    for i=1, #pos_list do
        minetest.swap_node(pos_list[i], { name = "default:mese" })
    end
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
            absorb(pos)
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
