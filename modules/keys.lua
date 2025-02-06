-- modules/keybindings.lua
local awful = require("awful")

globalkeys = gears.table.join(
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end),
    awful.key({ modkey, "Shift"   }, "r", function () awesome.restart() end),
    awful.key({ modkey, "Control" }, "q", awesome.quit),
    awful.key({ modkey, "Shift"   }, "q", function () awesome.quit() end)
)

-- Bind all key numbers to tags
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9, function ()
            local tag = awful.screen.focused().tags[i]
            if tag then
                tag:view_only()
            end
        end)
    )
end

root.keys(globalkeys)
