-- **********************************************************************************
--                                                                  __ _
--   __ ___      _____  ___  ___  _ __ ___   ___    ___ ___  _ __  / _(_) __ _
--  / _` \ \ /\ / / _ \/ __|/ _ \| '_ ` _ \ / _ \  / __/ _ \| '_ \| |_| |/ _` |
-- | (_| |\ V  V /  __/\__ \ (_) | | | | | |  __/ | (_| (_) | | | |  _| | (_| |
--  \__,_| \_/\_/ \___||___/\___/|_| |_| |_|\___|  \___\___/|_| |_|_| |_|\__, |
--                                                                       |___/
-- ********************************* @author davidk55 *******************************

local hotkeys_popup = require("awful.hotkeys_popup.widget")

local obsidian_rule_any = { class = { "obsidian" } }
for group_name, group_data in pairs({
  ["obsidian: folding"] = { color = "#514568", rule_any = obsidian_rule_any },
  ["obsidian: windows"] = { color = "#514568", rule_any = obsidian_rule_any },
  ["obsidian: searching"] = { color = "#514568", rule_any = obsidian_rule_any },
  ["obsidian: sidebar"] = { color = "#514568", rule_any = obsidian_rule_any },
  ["obsidian: navigation"] = { color = "#514568", rule_any = obsidian_rule_any },
  ["obsidian: word manipulation"] = { color = "#514568", rule_any = obsidian_rule_any },
  ["obsidian: theme"] = { color = "#514568", rule_any = obsidian_rule_any },
  ["obsidian: other"] = { color = "#514568", rule_any = obsidian_rule_any },
}) do
  hotkeys_popup.add_group_rules(group_name, group_data)
end

local obsidian_keys = {

  ["obsidian: folding"] = {
    {
      modifiers = {},
      keys = {
        ["za"] = "toggle fold the current line",
        ["zM"] = "fold all headings and lists",
        ["zR"] = "unfold all headings and lists",
      },
    },
  },

  ["obsidian: windows"] = {
    {
      modifiers = { "Ctrl+w" },
      keys = {
        ["h"] = "focus the left pane",
        ["j"] = "focus the pane below",
        ["k"] = "focus the pane above",
        ["l"] = "focus the right pane",
        ["v"] = "split vertically",
        ["s"] = "split horizontally",
        ["q"] = "close active pane",
      },
    },
  },

  ["obsidian: searching"] = {
    {
      modifiers = { "leader" },
      keys = {
        ["ff"] = "global omni search",
        ["fb"] = "omni search in current file (buffer)",
        ["/"] = "remove current search highlighting",
      },
    },
  },

  ["obsidian: sidebar"] = {
    {
      modifiers = { "leader" },
      keys = {
        ["u"] = "toggle left sidebar",
        ["o"] = "toggle right sidebar",
      },
    },
  },

  ["obsidian: theme"] = {
    {
      modifiers = { "leader" },
      keys = {
        ["0"] = "use light mode",
        ["-"] = "use dark mode",
      },
    },
  },

  ["obsidian: other"] = {
    {
      modifiers = { "leader" },
      keys = {
        ["g"] = "open graph view",
        ["e"] = "open emoji toolbar",
        ["s"] = "toggle source mode",
        [";"] = "show starred pane",
      },
    },
  },
}

hotkeys_popup.add_hotkeys(obsidian_keys)
