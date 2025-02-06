-- modules/wibar.lua
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

-- Create a wibox (top bar)
mywibox = awful.wibar({ position = "top", screen = s })

-- Add widgets to the wibox
mywibox:setup {
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
        layout = wibox.layout.fixed.horizontal,
        mylauncher,
    },
    nil,  -- Middle widget (nothing)
    { -- Right widgets
        layout = wibox.layout.fixed.horizontal,
        mytextclock,
        s.mylayoutbox,
    },
}
