-----------------------------------------------------------------
--     ___             _          _   __  __                   --
--    / __|_ _ __ _ __| |_____ __| | |  \/  |___ _______  _    --
--   | (__| '_/ _` / _| / / -_) _` | | |\/| / _ (_-<_-< || |   --
--    \___|_| \__,_\__|_\_\___\__,_| |_|  |_\___/__/__/\_, |   --
--                                                     |__/    --
-----------------------------------------------------------------
--                       Sirrobzeroone                         --
-----------------------------------------------------------------

local m_name = minetest.get_current_modname()
local S = minetest.get_translator(minetest.get_current_modname())

-- Alias for cracked_mossy nodes
minetest.register_alias("cracked_mossy:cracked_stone_block", "cracked_castle:cracked_stone_block")
minetest.register_alias("cracked_mossy:mossy_stone_block"  , "cracked_castle:mossy_stone_block")
minetest.register_alias("cracked_mossy:cracked_stonebrick" , "cracked_castle:cracked_stonebrick")
minetest.register_alias("cracked_mossy:mossy_stonebrick"   , "cracked_castle:mossy_stonebrick")

-- Clear cracked castle recipes for consistancy
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

-- Override cracked castle overlay texture
local crack_castle = {["cracked_stonebrick"] = {"default_stone_brick.png^(cracked_mossy_overlay_brick2_crack.png^[multiply:#9c9796^[opacity:170)"},
					  ["mossy_stonebrick"]   = {"default_stone_brick.png^(cracked_mossy_overlay_mossy.png^[opacity:210)"},
					  ["cracked_stone_block"]= {"default_stone_block.png^(cracked_mossy_overlay_block_crack.png^[multiply:#9c9796^[opacity:170)"},
					  ["mossy_stone_block"]  = {"default_stone_block.png^(cracked_mossy_overlay_mossy.png^[opacity:210)"}				  
					 }
					 

for node_name,image in pairs(crack_castle) do
	
	-- overide main node texture
	local node_def = table.copy(minetest.registered_nodes["cracked_castle:"..node_name])
	node_def.tiles = image
	
	minetest.register_node(":cracked_castle:"..node_name,node_def)
	
	-- overide stair version texture
	local stairs = {"stairs:slab_","stairs:stair_","stairs:stair_outer_","stairs:stair_inner_"}
	for k,v in pairs(stairs) do
		
		local stair_node_def = table.copy(minetest.registered_nodes[v..node_name])
		stair_node_def.tiles = image
		minetest.register_node(":"..v..node_name,stair_node_def)
		
	end
	
	-- add walls for bricks
	if string.find(node_name,"cracked_stonebrick") then
		
		local description = node_def.description
		
		if string.find(node_def.description, "@") then
			description = cracked_mossy.clean_desc(node_def.description)
		end
		
		walls.register(	m_name..":"..node_name.."_wall", 
					S(description.." Wall"), 
					image,
					"cracked_castle:"..node_name, 
					node_def.sounds)
	end	
end


