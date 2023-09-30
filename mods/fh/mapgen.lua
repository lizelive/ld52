
-- minetest.register_node("fh:cave_air", {
--     description = "Air Hard",
--     drawtype = "airlike",
--     paramtype = "light",
--     sunlight_propagates = true,
--     walkable = false,
--     pointable = false,
--     diggable = false,
--     buildable_to = true,
--     floodable = false,
--     air_equivalent = true,
--     is_ground_content = false,
--     groups = {not_in_creative_inventory = 1},
--     sounds = default.node_sound_defaults(),
-- })

-- minetest.register_on_generated(function(minp, maxp, blockseed)
--     local r = 500

--     if minp.x > r or minp.z > r or
--             maxp.x < -r or maxp.z < -r then
--         return
--     end
    
--     -- minetest.debug("generated " .. count)
--     local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
--     -- clear lighting
--     vm:set_lighting({day = 0, night = 0})

--     local data = vm:get_data()
--     local light_data = vm:get_light_data()
--     local area = VoxelArea:new({MinEdge = emin, MaxEdge = emax})
--     local c_air = minetest.get_content_id("air")
--     local c_ignore = minetest.get_content_id("ignore")
    
--     for z = minp.z - 1, maxp.z + 1 do
--         for y = minp.y - 1, maxp.y + 1 do
--             for x = minp.x - 1, maxp.x + 1 do
--                 local d = vector.length(vector.new(x, 0, z))
--                 local vi = area:index(x, y, z)
--                 if  d < r then
--                     data[vi] = c_air
--                 end
--                 if d <= r then
--                     light_data[vi] = 255
--                 end
--             end
--         end
--     end

--     vm:set_data(data)
--     vm:set_light_data(light_data)
--     vm:calc_lighting()
--     vm:write_to_map()
-- end)