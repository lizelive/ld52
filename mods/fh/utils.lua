function fh.get_nearby_players(pos, radius)
    local players = {}
    for _, player in ipairs(minetest.get_connected_players()) do
        local player_pos = player:get_pos()
        if vector.distance(pos, player_pos) <= radius then
            table.insert(players, player)
        end
    end
    return players
end
