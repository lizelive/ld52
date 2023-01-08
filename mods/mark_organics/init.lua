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

