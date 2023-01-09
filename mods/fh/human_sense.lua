local function add_hud_waypoint(player, name, pos, color, image)
    return player:hud_add{
        hud_elem_type = image and "image_waypoint" or "waypoint",
        name = name,
        text = image or "m",
        scale = {x = 5, y = 5},
        world_pos = pos,
        number = color,
        image = image,
        z_index = -300
    }
end

local all_saved_huds = {}


local was_day = nil

local night_size = 0.4
local half_night_size = night_size / 2

local function hide_nametag(player)
    player:set_nametag_attributes({color = {a = 0, r = 255, g = 255, b = 255}})
end

local function show_nametag(player)
    player:set_nametag_attributes({color = {a = 255, r = 255, g = 255, b = 255}})
end

local function get_is_day()
    local time_of_day = minetest.get_timeofday()

    return (time_of_day > half_night_size) and (time_of_day < (1-half_night_size))
end

function fh.fix_player_nametag(player)
    local should_have_nametag = fh.class_is_survivor(player) ~= get_is_day()
    if should_have_nametag then
        show_nametag(player)
    else
        hide_nametag(player)
    end
end

function fh.step(dtime)
    local time_of_day = minetest.get_timeofday()
    
    local is_day =  get_is_day()
    if not (is_day == was_day) then

        if is_day then
            minetest.chat_send_all("The sun brings clearity for the survivors! Gather resources! (humans nametags are invisble)")
        else
            minetest.chat_send_all("The night is a good time to harvest survivors! (monster nametags are invisble)")
        end
        local players = minetest.get_connected_players()
        for _, player in ipairs(players) do
            fh.fix_player_nametag(player)
    end
    end

    was_day = is_day

    -- todo : let humans know they are being watched

    local survivors = {}
    local scythers = {}
    -- show nametags for players
    -- for _, player in ipairs(players) do
    --     local player_name = player:get_player_name()

    --     local saved_huds = all_saved_huds[player_name] or {}
        
    --     for _, saved_hud in ipairs(saved_huds) do player:hud_remove(saved_hud) end
    --     all_saved_huds[player_name] = {}
    --     -- clear players huds

    --     if fh.class_is_survivor(player) then
    --         table.insert(survivors, player)
    --     else
    --         table.insert(scythers, player)
    --     end
    --     -- sort player

    -- end
    -- for _, player in ipairs(scythers) do
    --     for _, target in ipairs(survivors) do
    --         local player_name = player:get_player_name()
    --         local saved_huds = all_saved_huds[player_name] or {}

    --         local color = 0xFF2301
    --         local hud_waypoint = add_hud_waypoint(player,
    --                                               target:get_player_name(),
    --                                               target:get_pos(), color, nil) -- "lh_harvest_icon.png"
    --         table.insert(saved_huds, hud_waypoint)

    --         all_saved_huds[player_name] = saved_huds
    --     end
    -- end
end

minetest.register_on_leaveplayer(function(player)
    all_saved_huds[player:get_player_name()] = nil
end)
