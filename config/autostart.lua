local awful = require("awful")

-- Autostart applications
local autostart_apps = {
    "nm-applet",       -- NetworkManager applet
    "blueman-applet",  -- Bluetooth applet
}

for _, app in ipairs(autostart_apps) do
    awful.spawn.with_shell(app)
end
