local awful = require("awful")

awful.rules.rules = {
    { rule = { class = "Firefox" },
      properties = { floating = true, width = 800, height = 600 } },

    { rule = { class = "Gimp" },
      properties = { floating = true } },

    -- Add more rules as needed...
}
