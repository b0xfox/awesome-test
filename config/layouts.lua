local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local lain = require("lain")

awful.layout.layouts = {
    awful.layout.suit.tile,  -- Default tile layout
    awful.layout.suit.floating,  -- Floating layout
    lain.layout.termfair,   -- A more advanced layout (like a terminal-friendly layout)
    -- Add other layouts if needed...
}
