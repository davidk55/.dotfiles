-- **********************************************************************************
--                                                                  __ _
--   __ ___      _____  ___  ___  _ __ ___   ___    ___ ___  _ __  / _(_) __ _
--  / _` \ \ /\ / / _ \/ __|/ _ \| '_ ` _ \ / _ \  / __/ _ \| '_ \| |_| |/ _` |
-- | (_| |\ V  V /  __/\__ \ (_) | | | | | |  __/ | (_| (_) | | | |  _| | (_| |
--  \__,_| \_/\_/ \___||___/\___/|_| |_| |_|\___|  \___\___/|_| |_|_| |_|\__, |
--                                                                       |___/
-- ********************************* @author davidk55 *******************************

local hotkeys_popup = require("awful.hotkeys_popup.widget")

local nvim_rule_any = { name = { "dev" } }
for group_name, group_data in pairs({
  ["nvim: git"] = { color = "#8ec77e", rule_any = nvim_rule_any },
  ["nvim: lsp"] = { color = "#8ec77e", rule_any = nvim_rule_any },
  ["nvim: surround"] = { color = "#8ec77e", rule_any = nvim_rule_any },
  ["nvim: comment"] = { color = "#8ec77e", rule_any = nvim_rule_any },
  ["nvim: telescope"] = { color = "#8ec77e", rule_any = nvim_rule_any },
  ["nvim: barbar"] = { color = "#8ec77e", rule_any = nvim_rule_any },
}) do
  hotkeys_popup.add_group_rules(group_name, group_data)
end

local nvim_keys = {

  ["nvim: git"] = {
    {
      modifiers = {},
      keys = {
        ["ciw"] = "change inner hunk",
        ["viw"] = "select hole hunk",
      },
    },
    {
      modifiers = { "," },
      keys = {
        ["j"] = "jump to next hunk",
        ["k"] = "go to previous hunk",
        ["p"] = "preview the hunk",
        ["s"] = "stage the hunk",
        ["u"] = "undo the hunk (works only for last hunk)",
        ["r"] = "reset the hunk (restore)",
        ["S"] = "stage hole buffer",
        ["R"] = "diff hole buffer",
        ["b"] = "show commit where this hunk was added (blame)",
        ["tb"] = "toggle blame mode (show creator at the end)",
        ["td"] = "toggle deleted mode (previews deleted lines)",
        ["fh"] = "show commit history of current repo",
        ["fc"] = "show commit history only off the current buffer",
        ["fb"] = "show current branches",
        ["fs"] = "show the current git status",
      },
    },
  },

  ["nvim: lsp"] = {
    {
      modifiers = {},
      keys = {
        ["[d"] = "go to previous diagnostic",
        ["]d"] = "go to next diagnostic",
        ["gr"] = "go to reference of under under cursor",
        ["gd"] = "go to definition under cursor",
        ["gD"] = "got to declaration under cursor",
        ["gi"] = "go to implementation under cursor",
        ["K"] = "show information about under cursor",
      },
    },
    {
      modifiers = { "Ctrl" },
      keys = {
        ["space"] = "show completion",
      },
    },
    {
      modifiers = { "leader" },
      keys = {
        ["dd"] = "show diagnostic information",
        ["dl"] = "show diagnostic list",
        ["lf"] = "format currnt buffer",
        ["la"] = "do a code action",
        ["rn"] = "rename under cursor",
        ["wa"] = "add workspace directory",
        ["wr"] = "remove workspace directory",
        ["wl"] = "list current workspace",
        ["D"] = "go to definition under cursor (type)",
      },
    },
  },

  ["nvim: surround"] = {
    {
      modifiers = {},
      keys = {
        -- ['cs']="change the surroundings",
        ["cs@1@2"] = "change a surrounding (@1 = new sur, #2 = old sur)",
        ["ys@1@2"] = "insert a surrounding (@1 = text to sur, #2 = new sur)",
        ["ds@1"] = "delete a surrounding (@1 = sur to delete)",
        ["cst@1"] = "change the surrounding html tag (@1 = the new html tag)",
        ["cse@1"] = "change the surrounding latex class (environment (@1 = the new latex class)",
      },
    },
  },

  ["nvim: comment"] = {
    {
      modifiers = {},
      keys = {
        ["gcc"] = "comment current line with line comment",
        ["gbc"] = "comment current line with blockwise comment",
        ["gc"] = "visual: comment selected line/s with line comments",
        ["gb"] = "visual: comment selected line/s with blockwise comments",
        ["gco"] = "create a comment above the current line",
        ["gcO"] = "create a comment under the current line",
        ["gcA"] = "create a comment at the end of the current line",
        ["gciw"] = "comment the next word",
        ["gc$"] = "comment to the end of the line",
        ["gcip"] = "comment insde a paragraph",
      },
    },
  },

  ["nvim: telescope"] = {
    {
      modifiers = { "leader" },
      keys = {
        ["ff"] = "fzf search for files",
        ["fg"] = "word search in current directory tree",
        ["fb"] = "switch between current buffers",
        ["fh"] = "help page search",
        ["f/"] = "search in search history",
        ["f:"] = "search in command history",
        ['f"'] = "show registers and paste from them",
        ["fr"] = "show command to run",
        ["fk"] = "show keymappings",
      },
    },
  },

  ["nvim: barbar"] = {
    {
      modifiers = { "Alt" },
      keys = {
        ["c"] = "close current buffer",
        ["."] = "go to next buffer",
        [","] = "go to previous buffer",
      },
    },
    {
      modifiers = { "Alt+Shift" },
      keys = {
        ["."] = "move current buffer to the right",
        [","] = "move current buffer to the left",
      },
    },
    {
      modifiers = { "leader" },
      keys = {
        ["bb"] = "show chars for each buffer to fast jump",
        ["bn"] = "order buffers by name",
        ["bl"] = "order buffers by language",
      },
    },
  },
}

hotkeys_popup.add_hotkeys(nvim_keys)
