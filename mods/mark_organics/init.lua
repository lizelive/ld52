minetest.debug("i eat people")


local organic_groups = {
    "fleshy", "meat", "eatable", "flora", "grass"
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
        node.groups["organic"] = 1
        minetest.override_item(node.name, {groups=node.groups})
    end
end

minetest.debug("i ate people")

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