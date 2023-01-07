minetest.debug("i eat people")

-- minetest.debug(minetest.write_json(minetest.registered_nodes))

minetest.debug("i ate people")

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
