-- modules/signals.lua
local awful = require("awful")

client.connect_signal("manage", function (c)
    if awesome.startup then
        awful.placement.no_offscreen(c)
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
