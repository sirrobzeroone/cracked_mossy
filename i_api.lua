----------------------------------------------------------------
--     ___             _          _   __  __                   --
--    / __|_ _ __ _ __| |_____ __| | |  \/  |___ _______  _    --
--   | (__| '_/ _` / _| / / -_) _` | | |\/| / _ (_-<_-< || |   --
--    \___|_| \__,_\__|_\_\___\__,_| |_|  |_\___/__/__/\_, |   --
--                                                     |__/    --
-----------------------------------------------------------------
--                       Sirrobzeroone                         --
-----------------------------------------------------------------

----------------------------
--       Functions        --
----------------------------
cracked_mossy.clean_desc = function(in_string)
	-- Function to remove the translation wrapper text
	-- from the base node description 
	local desc_1 = string.split(in_string, ")") -- 1-\27(T@default), 2-Stone Block\27E
	local desc_2 = string.gsub(desc_1[2], "\27E", "")        
	return desc_2	

end

cracked_mossy.register_node = function(name, def)

-- def {color, brick, type stairs, walls}
	-- color     = #RRGGBB defines a color in hexadecimal format
	-- c_opacity = How dark the crack overlay is default is 170 or 66%
	-- brick     = block/null, big, small
	-- types     = crack/null, moss, both
	-- stairs    = true - all stairs and slabs registered if mod installed
	-- walls     = true - walls registered if mod installed
	-- walls_n   = registered name of wall, if not provided wall wont register
	-- abm       = true - adds an abm to convert node to moss variant
	
	local default_exist = minetest.get_modpath("default")
	local stairs_exist = minetest.get_modpath("stairs")
	local walls_exist = minetest.get_modpath("walls")
	local m_name = minetest.get_current_modname()
	local S = minetest.get_translator(m_name)
	local node_def_c = {}
	local node_def_m = {}	
	local src_node = table.copy(minetest.registered_nodes[name])
	
	-- data check
		
	-- check we have source node data
	if not src_node then
		minetest.log("info", "Cracked_Mossy - Supplied name is not a registered node - "..dump(name)) 
		return
	end
	
	-- check brick value is expected
	if not def.brick or type(def.brick) ~= "string" then
		def.brick = "block"
	
	end
	
	def.brick = string.lower(def.brick)
	
	if def.brick ~= "block" and  
	   def.brick ~= "big" and
	   def.brick ~= "small" then
	   
		def.brick = "block"
	end

	-- check type value is expected
	if not def.brick or type(def.brick) ~= "string" then
		def.types = "crack"
	
	end	
	def.types  = string.lower(def.types)
	
	if def.types ~= "crack" and  
	   def.types ~= "moss" and
	   def.types ~= "both" then
	   
		def.brick = "crack"
	end
	
	if not def.c_opacity or 
	   def.c_opacity < 0 or 
	   def.c_opacity > 255 then
	   
		def.c_opacity = 170
	end
	
	-- get node base name
	local reg_name = string.split(name, ":")
	local reg_name = reg_name[2]
	
	----------------------------
	-- start of registeration --
	----------------------------
			
	-- Parts of Definition identical for cracked/mossy variants
	-- Note: dont try and combine as when both reg you'll get a 
	-- texture issue - looks/points like cracked  but texture
	-- when placed is mossy.
	
	node_def_c.paramtype2   = src_node.paramtype2
	node_def_c.place_param2 = src_node.place_param2 
	node_def_c.is_ground_content = src_node.is_ground_content
	node_def_c.groups = src_node.groups
	node_def_c.sounds = src_node.sounds
	
	node_def_m.paramtype2   = src_node.paramtype2
	node_def_m.place_param2 = src_node.place_param2 
	node_def_m.is_ground_content = src_node.is_ground_content
	node_def_m.groups = src_node.groups
	node_def_m.sounds = src_node.sounds
	
	-- Register cracked version 	
	if def.types == "crack" or 
	   def.types == "both" then
		
	-- Clean up node description
		if string.find(src_node.description, "@") then      
			src_node.description = cracked_mossy.clean_desc(src_node.description)
		end
	
		node_def_c.description  = S("Cracked "..src_node.description)
		node_def_c.tiles = {src_node.tiles[1].."^(cracked_mossy_overlay_"..def.brick.."_crack.png^[multiply:"..def.color.."^[opacity:"..def.c_opacity..")"}
			
		minetest.register_node(m_name..":cracked_"..reg_name,node_def_c)
		
		if default_exist or 
		minetest.registered_nodes["mcl_furnaces:furnace"] then
		
			minetest.register_craft({
				type = "cooking",
				output = m_name..":cracked_"..reg_name,
				recipe = name,
			})
		end

	
		-- Stairs Cracked
		if def.stairs == true then
		-- stairs.register_stair_and_slab(subname, recipeitem, groups, 
		--                                images, desc_stair, desc_slab,
		--								  sounds, worldaligntex, desc_stair_inner, desc_stair_outer)		
			if stairs_exist then
				stairs.register_stair_and_slab(
									"cracked_"..reg_name, 
									m_name..":cracked_"..reg_name, 
									node_def_c.groups, 
									{src_node.tiles[1].."^(cracked_mossy_overlay_"..def.brick.."_crack.png^[multiply:"..def.color.."^[opacity:"..def.c_opacity..")"}, 
									"Cracked ".. src_node.description .." Stairs", 
									"Cracked ".. src_node.description .." Slab",
									node_def_c.sounds, 
									true, 
									"Cracked Inner "..src_node.description.." Stairs", 
									"Cracked Outer "..src_node.description.." Stairs")
			else
				minetest.log("info", "Cracked_Mossy - Stairs mod not found, Stairs/Slabs not registered -"..m_name..":cracked_"..reg_name) 				
			end
		end	
	
		-- Walls Cracked
		-- walls.register(name, desc, texture, mat, sounds)
		if def.walls == true then
			if walls_exist then		
				walls.register(	m_name..":cracked_"..reg_name.."_wall", 
								S("Cracked "..src_node.description.." Wall"), 
								{src_node.tiles[1].."^(cracked_mossy_overlay_"..def.brick.."_crack.png^[multiply:"..def.color.."^[opacity:"..def.c_opacity..")"},
								m_name..":cracked_"..reg_name, 
								node_def_c.sounds)
								
			else
				minetest.log("info", "Cracked_Mossy - Walls mod not found, Walls not registered.") 
		
			end
		end
	end

	
	-- Register mossy version
	if def.types == "moss" or 
	   def.types == "both" then
	
		-- Clean up node description
		if string.find(src_node.description, "@") then
			src_node.description = cracked_mossy.clean_desc(src_node.description)
		end
	
		node_def_m.description  = S("Mossy "..src_node.description)
		node_def_m.tiles = {src_node.tiles[1].."^(cracked_mossy_overlay_mossy.png^[opacity:210)"}
			
		minetest.register_node(m_name..":mossy_"..reg_name,node_def_m)
		
		-- Stairs Mossy
		if def.stairs == true then
		-- stairs.register_stair_and_slab(subname, recipeitem, groups, 
		--                                images, desc_stair, desc_slab,
		--								  sounds, worldaligntex, desc_stair_inner, desc_stair_outer)		
			if stairs_exist then
				stairs.register_stair_and_slab(
									"mossy_"..reg_name, 
									m_name..":mossy_"..reg_name, 
									node_def_m.groups, 
									{src_node.tiles[1].."^(cracked_mossy_overlay_mossy.png^[opacity:210)"}, 
									"Mossy ".. src_node.description .." Stairs", 
									"Mossy ".. src_node.description .." Slab",
									node_def_m.sounds, 
									true, 
									"Mossy Inner "..src_node.description.." Stairs", 
									"Mossy Outer "..src_node.description.." Stairs")
			else
				minetest.log("info", "Cracked_Mossy - Stairs mod not found, Stairs/Slabs not registered - "..m_name..":mossy_"..reg_name) 				
			end
		end	
		
		-- Walls Mossy
		-- walls.register(name, desc, texture, mat, sounds)
		if def.walls == true then
			if walls_exist then		
				walls.register(	m_name..":mossy_"..reg_name.."_wall", 
								S("Mossy "..src_node.description.." Wall"), 
								{src_node.tiles[1].."^(cracked_mossy_overlay_mossy.png^[opacity:210)"},
								m_name..":mossy_"..reg_name, 
								node_def_m.sounds)
								
			else
				minetest.log("info", "Cracked_Mossy - Walls mod not found, Walls not registered.") 
		
			end
		end		
				
		-- Register moss growth abm if true
		if def.abm == true then
			
			-- randomise ABM time interval slightly,
			-- for comp load spread - max spread 3 seconds, with 0.1 spacing
			local ran_int = math.random(30)/10 
			
			local node_target = {name}
			local moss_corr = {[name] = m_name..":mossy_"..reg_name}  
						
			if def.stairs == true and stairs_exist then			
				local splt_reg_name = string.split(name, ":")
				
				-- note nil impact if node not registered
				table.insert(node_target, "stairs:slab_"..splt_reg_name[2])
				table.insert(node_target, "stairs:stair_"..splt_reg_name[2])
				table.insert(node_target, "stairs:stair_outer_"..splt_reg_name[2])
				table.insert(node_target, "stairs:stair_inner_"..splt_reg_name[2])
				
				moss_corr["stairs:slab_"..splt_reg_name[2]] = "stairs:slab_mossy_"..splt_reg_name[2]
				moss_corr["stairs:stair_"..splt_reg_name[2]] = "stairs:stair_mossy_"..splt_reg_name[2]
				moss_corr["stairs:stair_outer_"..splt_reg_name[2]] = "stairs:stair_outer_mossy_"..splt_reg_name[2]
				moss_corr["stairs:stair_inner_"..splt_reg_name[2]] = "stairs:stair_inner_mossy_"..splt_reg_name[2]
				
			end
			
			if def.walls == true and 
			   def.wall_n and 		
			   walls_exist then
			   
			   table.insert(node_target, def.wall_n)
				moss_corr[def.wall_n] = m_name..":mossy_"..reg_name.."_wall"
			
			end
			
			minetest.register_abm({
				label = reg_name.." moss growth",
				nodenames = node_target,
				neighbors = {"group:water"},
				interval = 15 + ran_int,
				chance = 200,
				catch_up = false,
				action = function(pos, node)
					node.name = moss_corr[node.name]
					if node.name then
						minetest.set_node(pos, node)
					end
				end
			})		
		end
	end	
end