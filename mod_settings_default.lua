-----------------------------------------------------------------
--     ___             _          _   __  __                   --
--    / __|_ _ __ _ __| |_____ __| | |  \/  |___ _______  _    --
--   | (__| '_/ _` / _| / / -_) _` | | |\/| / _ (_-<_-< || |   --
--    \___|_| \__,_\__|_\_\___\__,_| |_|  |_\___/__/__/\_, |   --
--                                                     |__/    --
-----------------------------------------------------------------
--                       Sirrobzeroone                         --
-----------------------------------------------------------------

local S = minetest.get_translator(minetest.get_current_modname())
local crackcast_exist = minetest.get_modpath("cracked_castle")
local mywalls_exist = minetest.get_modpath("mywalls")
local brickwalls_exist = minetest.get_modpath("brickwalls")
local game_id = cracked_mossy.game_id
-------------
-- Alias's --
-------------
if not crackcast_exist then
	-- Cracked_Castle
	minetest.register_alias("cracked_castle:cracked_stone_block","cracked_mossy:cracked_stone_block")
	minetest.register_alias("cracked_castle:mossy_stone_block"  ,"cracked_mossy:mossy_stone_block")
	minetest.register_alias("cracked_castle:cracked_stonebrick" ,"cracked_mossy:cracked_stonebrick")
	minetest.register_alias("cracked_castle:mossy_stonebrick"   ,"cracked_mossy:mossy_stonebrick")
end

----------------------------
--         Walls          --
----------------------------
-- default dosen't include stone brick walls and 
-- desert stone brick walls,
local wall_sb  = "walls:stone_brick"
local wall_dsb = "walls:desert_stonebrick"
local wall_ssb = true
local wall_dssb = true
local wall_sssb = true

minetest.register_alias("brickwalls:stonebrick","walls:stone_brick")
minetest.register_alias("brickwalls:desert_stonebrick","walls:desert_stonebrick")

if not mywalls_exist and not brickwalls_exist then
	wall_ssb = false
	wall_dssb = false
	wall_sssb = false
end

if brickwalls_exist then
	
	wall_sb  = "brickwalls:stonebrick"
	wall_dsb = "brickwalls:desert_stonebrick"
	
	minetest.register_alias("walls:stone_brick","brickwalls:stonebrick")
	minetest.register_alias("walls:desert_stonebrick" ,"brickwalls:desert_stonebrick")	

end

if not mywalls_exist and not brickwalls_exist then

	walls.register(	":walls:stone_brick", 
					S("Stone Brick Wall"), 
					{"default_stone_brick.png"},
					"default:stonebrick", 
					default.node_sound_stone_defaults())
					
	walls.register(	":walls:desert_stonebrick", 
					S("Desert Stone Brick Wall"), 
					{"default_desert_stone_brick.png"},
					"default:desert_stonebrick", 
					default.node_sound_stone_defaults())
end

----------------------------
--     Register Nodes     --
----------------------------
if not crackcast_exist then
	cracked_mossy.register_node("default:stone_block",{
		color  = "#9c9796",
		brick  = "block",
		types  = "both",
		stairs = true,
		walls  = false,
		abm    = true
	}) 

	cracked_mossy.register_node("default:stonebrick",{
		color  = "#9c9796",
		brick  = "brick2",
		types  = "both",
		stairs = true,
		walls  = true,
		wall_n = wall_sb,
		abm    = true
	})
end

cracked_mossy.register_node("default:desert_stone_block",{
	color  = "#c7856c",
	brick  = "block",
	types  = "both",
	stairs = true,
	walls  = false,
	abm    = true
})

cracked_mossy.register_node("default:desert_stonebrick",{
	color  = "#c7856c",
	brick  = "brick2",
	types  = "both",
	stairs = true,
	walls  = true,
	wall_n = wall_dsb,
	abm    = true
})

cracked_mossy.register_node("default:sandstone_block",{
	color     = "#fff9c3",
	c_opacity = 110,
	brick     = "block",
	types     = "crack",
	stairs    = true,
	walls     = false,
	abm       = false
})

cracked_mossy.register_node("default:sandstonebrick",{
	color     = "#fff9c3",
	c_opacity = 110,
	brick     = "brick2",
	types     = "crack",
	stairs    = true,
	walls     = wall_ssb,
	abm       = false
})

cracked_mossy.register_node("default:desert_sandstone_block",{
	color     = "#ffd8a1",
	c_opacity = 110,
	brick     = "block",
	types     = "crack",
	stairs    = true,
	walls     = false,
	abm       = false
})

cracked_mossy.register_node("default:desert_sandstone_brick",{
	color     = "#ffd8a1",
	c_opacity = 110,
	brick     = "brick2",
	types     = "crack",
	stairs    = true,
	walls     = wall_dssb,
	abm       = false
})

cracked_mossy.register_node("default:silver_sandstone_block",{
	color     = "#f7f5e8",
	c_opacity = 110,
	brick     = "block",
	types     = "crack",
	stairs    = true,
	walls     = false,
	abm       = false
})

cracked_mossy.register_node("default:silver_sandstone_brick",{
	color     = "#f7f5e8",
	c_opacity = 110,
	brick     = "brick2",
	types     = "crack",
	stairs    = true,
	walls     = wall_sssb,
	abm       = false
})