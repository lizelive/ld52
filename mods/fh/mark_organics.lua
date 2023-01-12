local S = default.get_translator

local target_absorb_from_mob = 10

local organic_groups = {
    fleshy = "fh:biomass", meat = "fh:biomass",
    eatable = "fh:biomass", flora = "fh:alien_egg",
    leaves="fh:trickle",
    spreading_dirt_type="fh:biomass_with_alien_grass",
    tree = "fh:tendril"
}


fh.corrupt_into = {}

fh.corrupt = function(pos, node)
    local name = node.name
    local into = fh.corrupt_into[name] or "fh:biomass"
    if into then
        minetest.swap_node(pos, {name=into})
    end
end


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
    local corrupt_into = nil
    for group, into in pairs(organic_groups) do
        if node.groups[group] then
            is_organic = true
            corrupt_into = into
            break
        end
    end
    if node.groups["hive"] == 1 then
        is_organic = false
    end
    
    if is_organic then
        local node_name = node.name
        fh.corrupt_into[node_name] = corrupt_into
        -- minetest.debug(node_name .. " is organic")
        local groups = shallow_copy(node.groups)
        groups["organic"]=1
        -- local groups = { organic=1}
        minetest.override_item(node_name, {groups=groups})
    end
end

