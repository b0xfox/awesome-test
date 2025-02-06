client.connect_signal("manage", function (c)
    -- Example: Place new clients in the center of the screen
    if not c.size_hints.user_position and not c.size_hints.program_position then
        awful.placement.centered(c)
    end
end)

-- Handle focus changes, e.g., change border color
client.connect_signal("focus", function(c)
    c.border_color = beautiful.border_focus
end)

client.connect_signal("unfocus", function(c)
    c.border_color = beautiful.border_normal
end)
