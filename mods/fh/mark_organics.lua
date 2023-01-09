local S = default.get_translator

local target_absorb_from_mob = 10

local organic_groups = {
    "fleshy", "meat", "eatable", "flora", "grass", "leaves", "soil"
}

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

