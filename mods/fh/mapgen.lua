
-- minetest.register_on_generated(function(minp, maxp, blockseed)
--     -- if minp.x < -1000 or minp.x > 1000 or minp.y < -1000 or minp.y > 1000 or minp.z < -1000 or minp.z > 1000 then
--     --     return
--     -- end
--     local count = 0

--     count = count + 1
--     -- minetest.debug("generated " .. count)
--     local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
    
--     -- clear lighting
--     vm:set_lighting({day = 0, night = 0})

--     local data = vm:get_data()
--     local light_data = vm:get_light_data()
--     local area = VoxelArea:new({MinEdge = emin, MaxEdge = emax})
--     local c_air = minetest.get_content_id("air")
--     local c_ignore = minetest.get_content_id("ignore")

--     for z = minp.z, maxp.z do
--         for y = minp.y, maxp.y do
--             for x = minp.x, maxp.x do

--                 if vector.length(vector.new(x, 0, z)) < 50 - y then
--                     local vi = area:index(x, y, z)
--                     light_data[vi] = 255
--                     data[vi] = c_air
--                     vi = vi + 1
--                 end
--             end
--         end
--     end

--     vm:set_data(data)
--     vm:set_light_data(light_data)
--     vm:calc_lighting()
--     vm:write_to_map()
-- end)