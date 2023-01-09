local S = default.get_translator

local absorb_tool_capabilities = {
    full_punch_interval = 0.8,
    damage_groups = {fleshy = 5, choppy = 10},

    -- This is only used for digging nodes, but is still required
    max_drop_level = 1,
    groupcaps = {
        fleshy = {
            times = {[1] = 2.5, [2] = 1.20, [3] = 0.35},
            uses = 30,
            maxlevel = 2
        }
    }
}

-- map what
local consume_map = {
    ["default:dirt_with_grass"] = {name = "lh_blocks:consumed_dirt_with_grass"},
    ["group:flora"] = {name = "lh_blocks:consumed_flora"}
}

local function absorb(player, pos)
    local pos1 = vector.subtract(pos, {x = 5, y = 5, z = 5})
    local pos2 = vector.add(pos, {x = 5, y = 5, z = 5})

    -- not sure if i should do find_nodes_in_area_under_air
    local pos_list = minetest.find_nodes_in_area(pos1, pos2, {"group:organic"})

    -- minetest.debug("absorb = " .. dump(pos_list))

    local points_earned = 0

    for i = 1, #pos_list do
        -- todo totally remove air blocks
        minetest.swap_node(pos_list[i],
                           {name = "fh:dirt_with_alien_grass"})
        points_earned = points_earned + 1
    end

    local obj_list = minetest.get_objects_in_area(pos1, pos2)
    for _, obj in pairs(obj_list) do
        if obj == player then break end
        local hp = obj:get_hp()
        -- local new_hp = math.max(0, hp - 10)
        -- obj:set_hp(new_hp)
        obj:punch(player, nil, absorb_tool_capabilities)
        local new_hp = obj:get_hp()
        local damge_done = hp - new_hp
        points_earned = points_earned + damge_done
        -- obj:get_entity_name() 
        -- minetest.debug("i eat people " ..
        --                    (obj:get_player_name() or obj:get_entity_name() or
        --                        "other") .. " and i did " .. damge_done)

    end

    local meta = player:get_meta()
    local total_biomass = meta:get_int(fh.keys.biomass)
    total_biomass = total_biomass + points_earned
    meta:set_int(fh.keys.biomass, total_biomass)
    -- minetest.debug("i ate " .. points_earned .. " now have " .. total_biomass)
end

minetest.register_tool("fh:consume", {
    description = "Harvest Biomass",
    inventory_image = "eat_tool.png",
    tool_capabilities = {
        full_punch_interval = 1.5,
        max_drop_level = 1,
        groupcaps = {
            crumbly = {
                maxlevel = 2,
                uses = 20,
                times = {[1] = 1.60, [2] = 1.20, [3] = 0.80}
            }
        },
        damage_groups = {fleshy = 2}
    },

    on_use = function(itemstack, user, pointed_thing)
        local pos = pointed_thing.under or user:get_pos()
        if pos then absorb(user, pos) end
    end
    -- default: nil
    -- When user pressed the 'punch/mine' key with the item in hand.
    -- Function must return either nil if inventory shall not be modified,
    -- or an itemstack to replace the original itemstack.
    -- e.g. itemstack:take_item(); return itemstack
    -- Otherwise, the function is free to do what it wants.
    -- The user may be any ObjectRef or nil.
    -- The default functions handle regular use cases.
})
