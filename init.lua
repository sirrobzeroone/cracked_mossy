-----------------------------------------------------------------
--     ___             _          _   __  __                   --
--    / __|_ _ __ _ __| |_____ __| | |  \/  |___ _______  _    --
--   | (__| '_/ _` / _| / / -_) _` | | |\/| / _ (_-<_-< || |   --
--    \___|_| \__,_\__|_\_\___\__,_| |_|  |_\___/__/__/\_, |   --
--                                                     |__/    --
-----------------------------------------------------------------
--                       Sirrobzeroone                         --
-----------------------------------------------------------------

----------------------------
--        Settings        --
----------------------------
cracked_mossy = {}
local m_name = minetest.get_current_modname()
local m_path = minetest.get_modpath(m_name)

local default_exist = minetest.get_modpath("default")
local crackcast_exist = minetest.get_modpath("cracked_castle")
cracked_mossy.game_id = Settings(minetest.get_worldpath()..DIR_DELIM..'world.mt'):get('gameid')

----------------------------
--         Files          --
----------------------------
dofile(m_path.."/i_api.lua")

if default_exist then
	dofile(m_path.."/mod_settings_default.lua")
end

if crackcast_exist then
	dofile(m_path.."/mod_settings_crackedcastle.lua")
end