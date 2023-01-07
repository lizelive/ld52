local S = minetest.get_translator(minetest.get_current_modname())

function ignite_tnt(pos, node, clicker, itemstack, pointed_thing)
    if itemstack:get_name() == "default:torch" then
        minetest.set_node(pos, {name = "alien_tnt:life_sap_tnt_lit"}) 
    end
end

minetest.register_node("alien_tnt:life_sap_tnt", {
	description = S("Plant Life Saping TNT"),
	tiles = {"tnt_top.png^[colorize:blue:50", "tnt_bottom.png^[colorize:blue:50", "tnt_side.png^[colorize:blue:50"},
    on_rightclick = ignite_tnt,
    groups = {dig_immediate = 2, tnt = 1, flammable = 5}
})

minetest.register_node("alien_tnt:life_sap_tnt_lit", {
	description = S("Plant Life Saping TNT"),
	tiles = {{name="tnt_top_burning_animated.png^[colorize:blue:50", animation={type = "vertical_frames", aspect_w = 16, aspect_h = 16}}, "tnt_bottom.png^[colorize:blue:50", "tnt_side.png^[colorize:blue:50"},
    on_construct = function(pos)
        minetest.get_node_timer(pos):start(5)
    end,
    on_timer = function(pos, elapsed)
        minetest.set_node(pos, {name="air"})
    end,
    groups = {dig_immediate = 2, tnt = 1, flammable = 5, not_in_creative_inventory = 1, falling_node = 1}
    drop = {},
})