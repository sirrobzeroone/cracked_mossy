# Cracked Mossy
Small mod that adds cracked and mossy versions of some of the basic blocks, 
to listed games below.  

## Supported Games
The below games have a configuration file included with Cracked Mossy that make use 
of the Cracked Mossy registration function and will add content to those games. Cracked Mossy
can be used with other games however the game designer will need to use the Cracked Mossy 
register function to register cracked or Mossy node content.
 
 ### Minetest Game
For base MTG assuming nil other mods theses nodes will be added:
	
	default:stone_brick - cracked and mossy version + stairs/slab and walls + Stone Brick Wall
	default:stone_block - cracked and mossy version + stairs/slab
	default:desert_stonebrick - cracked and mossy version + stairs/slab and walls + Desert Stone Brick Wall
	default:desert_stone_block - cracked and mossy version + stairs/slab
	default:sandstonebrick - cracked only + stairs/slab
	default:sandstone_block - cracked only + stairs/slab
	default:desert_sandstone_brick - cracked only + stairs/slab
	default:desert_sandstone_block - cracked only + stairs/slab
	default:silver_sandstone_brick - cracked only + stairs/slab
	default:silver_sandstone_block - cracked only + stairs/slab
 
 ### Mesecraft
Similar to MTG but respects that less base walls are avaliable for Mesecraft:
	
 	default:stone_brick - cracked and mossy version + stairs/slab and walls + Stone Brick Wall
	default:stone_block - cracked and mossy version + stairs/slab
	default:desert_stonebrick - cracked and mossy version + stairs/slab and walls + Desert Stone Brick Wall
	default:desert_stone_block - cracked and mossy version + stairs/slab
	default:sandstonebrick - cracked only + stairs/slab
	default:sandstone_block - cracked only + stairs/slab
	default:desert_sandstone_brick - cracked only + stairs/slab
	default:desert_sandstone_block - cracked only + stairs/slab
	default:silver_sandstone_brick - cracked only + stairs/slab
	default:silver_sandstone_block - cracked only + stairs/slab

## Mods that it will work alongside
Cracked Mossy will work along side the below, ie cracked_mossy will
register alias's if you decide to use Cracked_Castle. If using either of
the wall mods cracked versions of the sandstone brick walls will also
be registered.

 - Cracked_Castle
 - MyWalls
 - Brickwalls
 
note: Cracked_mossy will register stone brick and desert stone brick walls if no walls mods are found.

## Register Function
Cracked_Mossy includes a simple function for registering cracked and mossy versions of a registered node.

### Usage
```
cracked_mossy.register_node(source node name,{
		color  = <hex color string>,
		c_opacity = <0 to 255>,
		brick  = <block, brick2>,
		types  = <crack, moss, both>,
		stairs = <true, false>,
		walls  = <true, false>,
		wall_n = <source wall name>,
		abm    = <true, false>
	})
```
- Source node name - registered name of the node you wish to base the cracked and mossy versions on eg "default:stonebrick". The cracked and mossy versions will use the same node register settings as the source node eg same groups, sounds etc.

- color - hex color string of what color to tint the cracks when overlaid on the source node eg "#9c9796". Best to go very much lighter than you think, #9c9796 is a light grey and works well on default stone brick/block, "#c7856c" is light salmon works well on default desert stone brick/block. Selecting the correct color takes a little bit of trial and error.

- c_opacity - Optional, if not set will use 170 or about 66%.  Crack overlay opacity value range 0 to 255. hint lighter colored nodes need less opacity. 

- brick - Optional, if not set will default to "block" setting - Block is for solid nodes, brick2 is for nodes constructed of two large bricks in height.

- types - Optional, if not set will default to "crack" setting.
	- crack will only register a cracked version of the node
	- moss will only register a mossy version of the node
	- both will register both versions

- stairs - Optional, when set true and stairs mod is active, slabs, stairs, inner stairs and outer stair versions of the cracked/mossy nodes will register.

- walls - Optional, when set true and walls mod active, will register cracked/mossy wall versions.

- walls_n - Optional used if walls = true, you must provide the source wall name eg "walls:stone_brick", "brickwalls:stonebrick" or "mywallmod:stonebrick".
  
- abm - Optional, when set true will register an abm so normal nodes turn to mossy nodes when touching nodes in the water group. The abm when registered will randomise to an interval between 15 and 18 seconds. If no ABM is registered you will need to provide a way in game for your players to obtain mossy blocks as this is the only way currently to obtain mossy blocks using the cCracked Mossy mod.

#### Example
Register a simple cracked mossy version of defaults stone brick with mywalls installed:
```	
		cracked_mossy.register_node("default:stonebrick",{
		color  = "#9c9796",
		brick  = "brick2",
		types  = "both",
		stairs = true,
		walls  = true,
		wall_n = "walls:stone_brick",
		abm    = true
	})
```

### Manual usage
If preferred the texture overlays for cracks and moss can be used manually as part of a normal minetest.register_node() like the below or feel free to simply take the textures and create new textures the crack and moss textures are CC0.
	
#### Crack	
Block node:
	```tiles = {"base_texture_name^(cracked_mossy_overlay_block_crack.png^[multiply:#9c9796^[opacity:170)"}```
	
Brick node (2 high):
	```tiles = {"base_texture_name^(cracked_mossy_overlay_brick2_crack.png^[multiply:#9c9796^[opacity:170)"}```

#### Moss
	Moss node:
	```tiles = {"base_texture_name^(cracked_mossy_overlay_mossy.png^[opacity:210)"}```