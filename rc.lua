-- Libraries
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local hotkeys_popup = require("awful.hotkeys_popup").widget

-- Error handling (optional)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Import custom configurations
require("config.theme")         -- Theme and appearance
require("config.keys")          -- Keybindings
require("config.rules")         -- Window rules
require("config.layouts")       -- Layouts
require("config.signals")       -- Signal handling (e.g., window events)
require("config.autostart")     -- Applications to start at boot

-- Setup the screen, wibox, etc.
awful.screen.connect_for_each_screen(function(s)
    -- Initialize each screen (add wibox, set wallpaper, etc.)
    -- Here you can add widgets to your wibox
end)

-- More global settings, if needed

