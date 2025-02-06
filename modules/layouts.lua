-- modules/layouts.lua
local awful = require("awful")
local beautiful = require("beautiful")

-- Define default layouts
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.floating,
    awful.layout.suit.max,
    awful.layout.suit.magnifier,
    awful.layout.suit.spiral
}
