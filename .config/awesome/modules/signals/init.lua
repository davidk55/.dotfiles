-- **********************************************************************************
--                                                                  __ _
--   __ ___      _____  ___  ___  _ __ ___   ___    ___ ___  _ __  / _(_) __ _
--  / _` \ \ /\ / / _ \/ __|/ _ \| '_ ` _ \ / _ \  / __/ _ \| '_ \| |_| |/ _` |
-- | (_| |\ V  V /  __/\__ \ (_) | | | | | |  __/ | (_| (_) | | | |  _| | (_| |
--  \__,_| \_/\_/ \___||___/\___/|_| |_| |_|\___|  \___\___/|_| |_|_| |_|\__, |
--                                                                       |___/
-- ********************************* @author davidk55 *******************************

local awful = require("awful")
local theme = require("modules.theme")

-- ================ SLOPPY FOCUS ================
-- So that the focus follows the mouse
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

-- ================ FOCUS BORDER ================
client.connect_signal("focus", function(c) c.border_color = theme.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = theme.border_normal end)

-- ================ OTHER ================
-- Prevent clients from being unreachable after screen count changes.
client.connect_signal("manage", function(c)
    if awesome.startup
        and not c.size_hints.user_position
        and not c.size_hints.program_position then
        awful.placement.no_offscreen(c)
    end
end)

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
