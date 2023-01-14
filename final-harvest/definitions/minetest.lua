
---@meta

---@class Minetest
local minetest = {}

---@class Vector
---@field x number
---@field z number
---@field y number

ObjectRefs = {}
---@class ObjectRefs
---@field name string
-- ---@field get_pos function

---@return Vector pos the position
function ObjectRefs.get_pos() end


--- which players are online

---@return ObjectRefs[] 
function minetest.get_connected_players() end




return minetest