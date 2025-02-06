-- modules/variables.lua
-- Default variables

terminal = "xterm"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor
modkey = "Mod4"  -- Usually Mod4 is the Super key
altkey = "Mod1"  -- Usually Alt is Mod1

-- Other defaults like themes, etc.
beautiful.init(gears.filesystem.get_configuration_dir() .. "themes/default/theme.lua")
