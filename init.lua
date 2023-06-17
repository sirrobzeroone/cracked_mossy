-----------------------------------------------------------------
--     ___             _          _   __  __                   --
--    / __|_ _ __ _ __| |_____ __| | |  \/  |___ _______  _    --
--   | (__| '_/ _` / _| / / -_) _` | | |\/| / _ (_-<_-< || |   --
--    \___|_| \__,_\__|_\_\___\__,_| |_|  |_\___/__/__/\_, |   --
--                                                     |__/    --
-----------------------------------------------------------------
--                       Sirrobzeroone                         --
-----------------------------------------------------------------

--[[
Small mod that adds cracked and mossy versions of a few blocks.
Aware there is cracked castle by pampogokiraly however that adds
some other blocks which duplicates against cave realms for myself
as well as missing a few cracked versions I wanted. This mod wont
conflict with cracked castle if you use it.

Nodes Included/Covered
--default:stone_brick
	cracked and mossy version

--default:stone_block 
	cracked and mossy version

--default:desert_stonebrick
	cracked and mossy version

--default:desert_stone_block
	cracked and mossy version

--default:sandstonebrick
	cracked only
	
--default:sandstone_block
	cracked only
	
--default:desert_sandstone_brick
	cracked only
	
--default:desert_sandstone_block
	cracked only
	
--default:silver_sandstone_brick
	cracked only
	
--default:silver_sandstone_block
	cracked only
	
]]--


----------------------------
--        Settings        --
----------------------------
local S = minetest.get_translator(minetest.get_current_modname())
cracked_mossy = {}

local m_name = minetest.get_current_modname()
local m_path = minetest.get_modpath(m_name)

local def_exist = minetest.get_modpath("default")
local stairs_exist = minetest.get_modpath("stairs")
local crackcast_exist = minetest.get_modpath("cracked_castle")


local stone_sound
local basic_nodes

if def_exist then
	stone_sound = default.node_sound_stone_defaults()

	basic_nodes = {
		["default:stonebrick"]         = "cracked_mossy:cracked_stonebrick",
		["default:stone_block"]        = "cracked_mossy:cracked_stone_block",
		["default:desert_stonebrick"]  = "cracked_mossy:cracked_desertstonebrick",
		["default:desert_stone_block"] = "cracked_mossy:cracked_desertstoneblock",
		["default:sandstonebrick"]     = "cracked_mossy:cracked_sandstone_brick",
		["default:sandstone_block"]    = "cracked_mossy:cracked_sandstone_block",
		["default:desert_sandstone_brick"] = "cracked_mossy:cracked_desert_sandstone_brick",
		["default:desert_sandstone_block"] = "cracked_mossy:cracked_desert_sandstone_block",
		["default:silver_sandstone_brick"] = "cracked_mossy:cracked_silver_sandstone_brick",
		["default:silver_sandstone_block"] = "cracked_mossy:cracked_silver_sandstone_block"
	}
	
end

if crackcast_exist then
	basic_nodes["default:stonebrick"]  = "cracked_castle:cracked_stonebrick"
	basic_nodes["default:stone_block"] = "cracked_castle:cracked_stone_block"

end 

----------------------------
--    Register Nodes      --
----------------------------
cracked_mossy.nodes = {
	{name ="cracked_stonebrick" , desc = "Cracked Stone Brick", p2 ="facedir", pp2 = 0, grp = {cracky = 3, stone = 1}, reg = "cc"},
	{name ="mossy_stonebrick"   , desc = "Mossy Stone Brick"  , p2 ="facedir", pp2 = 0, grp = {cracky = 3, stone = 1}, reg = "cc"},
	{name ="cracked_stone_block", desc = "Cracked Stone Block", p2 ="facedir", pp2 = 0, grp = {cracky = 3, stone = 1}, reg = "cc"},
	{name ="mossy_stone_block"  , desc = "Mossy Stone Block"  , p2 ="facedir", pp2 = 0, grp = {cracky = 3, stone = 1}, reg = "cc"},
	{name ="cracked_desertstonebrick", desc = "Cracked Desert Stone Brick" , p2 ="facedir", pp2 = 0, grp = {cracky = 3, stone = 1}, reg = "all"},
	{name ="mossy_desertstonebrick"  , desc = "Mossy Desert Stone Brick"   , p2 ="facedir", pp2 = 0, grp = {cracky = 3, stone = 1}, reg = "all"},
	{name ="cracked_desertstoneblock", desc = "Cracked Desert Stone Block" , p2 ="facedir", pp2 = 0, grp = {cracky = 3, stone = 1}, reg = "all"},
	{name ="mossy_desertstoneblock"  , desc = "Mossy Desert Stone Block"   , p2 ="facedir", pp2 = 0, grp = {cracky = 3, stone = 1}, reg = "all"},
	{name ="cracked_sandstone_block" , desc = "Cracked Sandstone Block" , p2 ="facedir", pp2 = 0, grp = {cracky = 3, stone = 1}, reg = "all"},
	{name ="cracked_sandstone_brick" , desc = "Cracked Sandstone Brick" , p2 ="facedir", pp2 = 0, grp = {cracky = 3, stone = 1}, reg = "all"},
	{name ="cracked_desert_sandstone_block" , desc = "Cracked Desert Sandstone Block" , p2 ="facedir", pp2 = 0, grp = {cracky = 3, stone = 1}, reg = "all"},
	{name ="cracked_desert_sandstone_brick" , desc = "Cracked Desert Sandstone Brick" , p2 ="facedir", pp2 = 0, grp = {cracky = 3, stone = 1}, reg = "all"},
	{name ="cracked_silver_sandstone_block" , desc = "Cracked Silver Sandstone Block" , p2 ="facedir", pp2 = 0, grp = {cracky = 3, stone = 1}, reg = "all"},
	{name ="cracked_silver_sandstone_brick" , desc = "Cracked Silver Sandstone Brick" , p2 ="facedir", pp2 = 0, grp = {cracky = 3, stone = 1}, reg = "all"}	
}

for k,v in ipairs(cracked_mossy.nodes) do

	if crackcast_exist and v.reg == "cc" then
		
		local def_names = {
			"cracked_castle:"..v.name,
			"stairs:slab_"..v.name,		
			"stairs:stair_"..v.name,
			"stairs:stair_inner_"..v.name,
			"stairs:stair_outer_"..v.name		
		}
		
		for _,node_name in ipairs(def_names) do
			local def_n = table.copy(minetest.registered_nodes[node_name])
			def_n.tiles = {"cracked_mossy_"..v.name..".png"}			
			minetest.register_node(":"..node_name, def_n)
			
			if string.find(node_name, "cracked_castle") then
				minetest.register_alias("cracked_mossy:"..v.name, node_name)
			end
			
		end
		
	else
	
		local def = {}
		
		def.description  = S(v.desc)
		def.paramtype2   = v.p2
		def.place_param2 = v.pp2
		def.tiles = {"cracked_mossy_"..v.name..".png"}
		def.is_ground_content = false
		def.groups = v.grp
		def.sounds = stone_sound	
		
		minetest.register_node("cracked_mossy:"..v.name,def)
		
		if stairs_exist then	
			stairs.register_stair_and_slab(	v.name, 
											"cracked_mossy:"..v.name, 
											v.grp, 
											{"cracked_mossy_"..v.name..".png"}, 
											v.desc.." Stairs", 
											v.desc.." Slab",
											stone_sound, 
											true, 
											"Inner "..v.desc.." Stairs", 
											"Outer "..v.desc.." Stairs")	
		end	
	end
end

----------------------------
--   Register Recipes     --
----------------------------

-- Clear cracked castle recipes for consistancy
if crackcast_exist then

	minetest.clear_craft({
		recipe = {
			{"default:stonebrick", "default:stonebrick", "default:stonebrick"},
			{"default:stonebrick", "default:pick_wood", "default:stonebrick"},
			{"default:stonebrick", "default:stonebrick", "default:stonebrick"}
		}
	})
	
	minetest.clear_craft({	
		recipe = {
			{"default:stone_block", "default:stone_block", "default:stone_block"},
			{"default:stone_block", "default:pick_wood", "default:stone_block"},
			{"default:stone_block", "default:stone_block", "default:stone_block"}
		}	
	})	
	
end

if def_exist then
	
	for input,output in pairs(basic_nodes) do
		minetest.register_craft({
			type = "cooking",
			output = output,
			recipe = input,
		})
	end
end