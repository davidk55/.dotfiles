-- **********************************************************************************
--                                                                  __ _
--   __ ___      _____  ___  ___  _ __ ___   ___    ___ ___  _ __  / _(_) __ _
--  / _` \ \ /\ / / _ \/ __|/ _ \| '_ ` _ \ / _ \  / __/ _ \| '_ \| |_| |/ _` |
-- | (_| |\ V  V /  __/\__ \ (_) | | | | | |  __/ | (_| (_) | | | |  _| | (_| |
--  \__,_| \_/\_/ \___||___/\___/|_| |_| |_|\___|  \___\___/|_| |_|_| |_|\__, |
--                                                                       |___/
-- ********************************* @author davidk55 *******************************

require("awful.autofocus")
local awful = require("awful")
local theme = require("theme")
local shortcuts = require("shortcuts")

-- ================ SET RULES ================
awful.rules.rules = {
    -- ================ CLIENTS DEFAULT RULE ================
    { rule = {},
        properties = { border_width = theme.border_width,
            border_color = theme.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = shortcuts.clientkeys,
            buttons = shortcuts.clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen
        }
    },

    -- ================ FLOATING RULES ================
    { rule_any = {
        role = {
            "toolbox", -- firefox: devtools
            "Msgcompose", -- thunderbird: writing a message
            "addressbook" -- thunderbird: address book
        },

        name = {
            "Event Tester", -- xev.
        },
    }, properties = { floating = true } },

    -- ================ APPLICATION SPECIFIC RULES ================
    { rule = { class = "obsidian" }, properties = { tag = " " } },

    { rule = { class = "KeePassXC" }, properties = { tag = " " } },

    { rule = { role = "3pane" }, properties = { tag = " " } },

    { rule = { instance = "discord" }, properties = { tag = " " } },

    { rule = { name = "dev" }, properties = { tag = " " } },

    { rule = { name = "term" }, properties = { tag = " " } },
}

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
