-- **********************************************************************************
--                                                                  __ _
--   __ ___      _____  ___  ___  _ __ ___   ___    ___ ___  _ __  / _(_) __ _
--  / _` \ \ /\ / / _ \/ __|/ _ \| '_ ` _ \ / _ \  / __/ _ \| '_ \| |_| |/ _` |
-- | (_| |\ V  V /  __/\__ \ (_) | | | | | |  __/ | (_| (_) | | | |  _| | (_| |
--  \__,_| \_/\_/ \___||___/\___/|_| |_| |_|\___|  \___\___/|_| |_|_| |_|\__, |
--                                                                       |___/
-- ********************************* @author davidk55 *******************************

local hotkeys_popup = require("awful.hotkeys_popup.widget")

local intellij_rule_any = { instance = { "jetbrains-idea" } }
for group_name, group_data in pairs({
  ["intellij: general"] = { color = "#d67933", rule_any = intellij_rule_any },
  ["intellij: lsp"] = { color = "#d67933", rule_any = intellij_rule_any },
  ["intellij: tabs"] = { color = "#d67933", rule_any = intellij_rule_any },
}) do
  hotkeys_popup.add_group_rules(group_name, group_data)
end

local intellij_keys = {

  ["intellij: general"] = {
    {
      modifiers = { "Ctrl" },
      keys = {
        ["space"] = "show completion",
      },
    },
    {
      modifiers = { "leader" },
      keys = {
        ["/"] = "remove current search highlighting",
        ["y"] = "yank to clipboard",
        ["p"] = "paste from clipboard",
        ["ff"] = "go to specific file",
        ["j"] = "swap current line with line below",
        ["k"] = "swap current line with line above",
      },
    },
    {
      modifiers = {},
      keys = {
        ["J"] = "join current line with line below",
      },
    },
    {
      modifiers = { "," },
      keys = {
        ["d"] = "delete to blackhole register",
      },
    },
  },

  ["intellij: lsp"] = {
    {
      modifiers = { "leader" },
      keys = {
        ["rn"] = "rename focused element",
        ["rf"] = "open refactor menu",
        ["ca"] = "do a code action",
        ["cf"] = "format current code",
        ["ri"] = "refactor imports",
        ["ec "] = "extract to class (in visual)",
        ["es"] = "extract to super class (in visual)",
        ["em"] = "extract to method (in visual)",
        ["ev"] = "extract as variable",
        ["ec"] = "extract as constant",
        ["ef"] = "extract as field",
        ["dd"] = "show current errors",
      },
    },
    {
      modifiers = {},
      keys = {
        ["gd"] = "go to declaration",
        ["gr"] = "go to declaration",
        ["gi"] = "go to implementation",
        ["gm"] = "go to super method",
        ["gt"] = "go to test",
        ["d["] = "go to the next error",
        ["d]"] = "go to the previous error",
        ["K"] = "show documentation of focused element",
      },
    },
  },

  ["intellij: tabs"] = {
    {
      modifiers = { "Alt" },
      keys = {
        [","] = "go to previous tab",
        ["."] = "go to next tab",
        ["n"] = "create new file",
        ["c"] = "close current file",
      },
    },
  },
}

hotkeys_popup.add_hotkeys(intellij_keys)
