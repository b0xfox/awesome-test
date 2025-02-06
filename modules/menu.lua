-- modules/menu.lua
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local menubar = require("menubar")

-- Define the AwesomeWM menu
myawesomemenu = {
    { "hotkeys", function() hotkeys_popup.show_help(nil) end },
    { "manual", terminal .. " -e man awesome" },
    { "edit config", editor_cmd .. " " .. awful.util.get_configuration_dir() .. "rc.lua" },
    { "restart", awesome.restart },
    { "quit", function() awesome.quit() end }
}

mymainmenu = awful.menu({
    items = {
        { "awesome", myawesomemenu, beautiful.awesome_icon },
        { "open terminal", terminal }
    }
})

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon, menu = mymainmenu })
