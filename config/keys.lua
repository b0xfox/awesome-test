local awful = require("awful")
local modkey = "Mod4"  -- Super key (Windows key)

local globalkeys = gears.table.join(
    -- Change focus between windows
    awful.key({ modkey,           }, "h", function () awful.tag.viewprev() end),
    awful.key({ modkey,           }, "l", function () awful.tag.viewnext() end),

    -- Launch a terminal
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end),

    -- Close a window
    awful.key({ modkey, "Shift"   }, "q", function () awesome.quit() end),

    -- Restart AwesomeWM
    awful.key({ modkey, "Control" }, "r", awesome.restart)
)

root.keys(globalkeys)
