-- main rc.lua file

-- Load required libraries
local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local menubar = require("menubar")

-- Load all the modules
require("modules.error_handling")
require("modules.variables")
require("modules.autostart")
require("modules.menu")
require("modules.keys")
require("modules.layouts")
require("modules.rules")
require("modules.signals")
require("modules.wibar")
