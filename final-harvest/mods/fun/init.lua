---@module 'minetest'
local minetest = require "minetest"

local function random()
    return 42
end


local players = minetest.get_connected_players()

for _, player in minetest.get_connected_players() do
    
    ---@type ObjectRefs
    local me = player
    ---@cast player ObjectRefs
    local pos = player:get_pos()
end

---@return Vector
local function get_pos()
    return {x=1, y=2, z=3}
end

local pos = get_pos()
local x = pos.x


local misc = modlib.persistence
misc.connected_players()