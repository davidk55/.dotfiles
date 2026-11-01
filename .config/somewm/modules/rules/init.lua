-- **********************************************************************************
--                                               __ _
--   ___  ___  _ __ ___   ___    ___ ___  _ __  / _(_) __ _
-- / __|/ _ \| '_ ` _ \ / _ \  / __/ _ \| '_ \| |_| |/ _` |
-- \__ \ (_) | | | | | |  __/ | (_| (_) | | | |  _| | (_| |
-- |___/\___/|_| |_| |_|\___|  \___\___/|_| |_|_| |_|\__, |
--                                                   |___/
-- ********************************* @author davidk55 *******************************

local awful = require("awful")
local ruled = require("ruled")
local gears = require("gears")
local dpi = require("beautiful.xresources").apply_dpi

ruled.client.connect_signal("request::rules", function()
  -- ================ RULES FOR ALL CLIENTS ================
  ruled.client.append_rule({
    rule = {},
    properties = {
      shape = gears.shape.rounded_rect,
      border_width = dpi(0),
      opacity = 0.6,
    },
  })
  -- ================ GENERAL FLOATING RULES ================
  local classes = {
    "anki",
    "mpv",
    "Emulator",
    "steamwebhelper",
    "Steam",
    "blueman-manager",
    "solaar",
    "qalculate-gtk",
    "Qalculate-gtk",
    "com.github.hluk.copyq",
    "com.nextcloud.desktopclient.nextcloud",
    "Godot_Engine",
    "obsidian-fzf",
    "io.github.focustimerhq.FocusTimer",
    "Pomotroid",
  }
  for _, current_class in ipairs(classes) do
    ruled.client.append_rule({
      rule = { class = current_class },
      -- properties = { floating = true, placement = awful.placement.centered, above = true },
      properties = { floating = true, placement = awful.placement.centered },
    })
  end

  local roles = {
    "toolbox", -- firefox: devtools
    "Msgcompose", -- thunderbird: writing a message
    "addressbook", -- thunderbird: address book
  }
  for _, current_role in ipairs(roles) do
    ruled.client.append_rule({
      rule = { class = current_role },
      -- properties = { floating = true, placement = awful.placement.centered, above = true },
      properties = { floating = true, placement = awful.placement.centered },
    })
  end

  local names = {
    "Event Tester", -- xev
    "Steam",
    "Friends List",
  }
  for _, current_name in ipairs(names) do
    ruled.client.append_rule({
      rule = { class = current_name },
      -- properties = { floating = true, placement = awful.placement.centered, above = true },
      properties = { floating = true, placement = awful.placement.centered },
    })
  end

  -- ================ SPECIFIC FLOATING RULES ================
  ruled.client.append_rule({
    rule = { class = "org.kde.dolphin" },
    -- properties = { width = 1110, height = 730, placement = awful.placement.centered, above = true, floating = true },
    properties = { width = 1110, height = 730, placement = awful.placement.centered, floating = true },
  })
  ruled.client.append_rule({
    rule = { class = "dolphin" },
    -- properties = { width = 1110, height = 730, placement = awful.placement.centered, above = true, floating = true },
    properties = { width = 1110, height = 730, placement = awful.placement.centered, floating = true },
  })
  ruled.client.append_rule({
    rule = { class = "org.mozilla.Thunderbird" },
    -- properties = { width = 1400, height = 900, placement = awful.placement.centered, above = true, floating = true },
    properties = { width = 1400, height = 900, placement = awful.placement.centered, floating = true },
  })
  ruled.client.append_rule({
    rule = { class = "obsidian-rg" },
    -- properties = { width = 1200, height = 700, above = true, floating = true },
    properties = { width = 1200, height = 700, floating = true },
  })
end)

-- ================ FOCUS RULES ================
client.connect_signal("focus", function(c)
  c.opacity = 1
end)
client.connect_signal("unfocus", function(c)
  c.opacity = 0.9
end)

-- ================ SLOPPY FOCUS ================
-- So that the focus follows the mouse
client.connect_signal("mouse::enter", function(c)
  c:activate({ context = "mouse_enter", raise = false })
end)

-- ================ PROPER FOCUS RESTORE ================

-- tag.connect_signal("property::selected", function(t)
--   if t.selected then
--     FOCUS_MASTER_IF_NEEDED(t.screen)
--   end
-- end)
--
-- screen.connect_signal("request::focus_restore", function(s)
--   FOCUS_MASTER_IF_NEEDED(s)
-- end)
