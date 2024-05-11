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
local theme = require("modules.theme")
local shortcuts = require("modules.shortcuts")

-- ================ SET RULES ================
awful.rules.rules = {
  -- ================ CLIENTS DEFAULT RULES ================
  {
    rule = {},
    properties = {
      border_width = theme.border_width,
      border_color = theme.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = shortcuts.clientkeys,
      buttons = shortcuts.clientbuttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen,
    },
  },

  -- ================ SPECIFIC FLOATING RULES ================
  {
    rule = { class = "Anki" },
    properties = { above = true },
  },
  {
    rule = { class = "dolphin" },
    properties = { width = 1110, height = 730, placement = awful.placement.centered, above = true },
  },
  {
    rule = { class = "Mailspring" },
    properties = { width = 1400, height = 900, placement = awful.placement.centered, above = true },
  },
  {
    rule = { class = "mpv" },
    properties = { placement = awful.placement.centered, above = true },
  },
  {
    rule = { class = "Steam" },
    properties = { placement = awful.placement.centered },
  },
  {
    rule = { class = "obsidian-fzf" },
    properties = { placement = awful.placement.centered, above = true },
  },
  {
    rule = { class = "obsidian-rg" },
    properties = { width = 1200, height = 700, above = true },
  },

  -- ================ GENERAL FLOATING RULES ================
  {
    rule_any = {
      role = {
        "toolbox", -- firefox: devtools
        "Msgcompose", -- thunderbird: writing a message
        "addressbook", -- thunderbird: address book
      },

      name = {
        "Event Tester", -- xev.
      },
      class = {
        "Anki",
        "dolphin",
        "Mailspring",
        "mpv",
        "obsidian-fzf",
        "obsidian-rg",
      },
    },
    properties = { floating = true },
  },
}
