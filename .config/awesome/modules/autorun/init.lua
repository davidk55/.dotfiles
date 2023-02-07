-- **********************************************************************************
--                                                                  __ _
--   __ ___      _____  ___  ___  _ __ ___   ___    ___ ___  _ __  / _(_) __ _
--  / _` \ \ /\ / / _ \/ __|/ _ \| '_ ` _ \ / _ \  / __/ _ \| '_ \| |_| |/ _` |
-- | (_| |\ V  V /  __/\__ \ (_) | | | | | |  __/ | (_| (_) | | | |  _| | (_| |
--  \__,_| \_/\_/ \___||___/\___/|_| |_| |_|\___|  \___\___/|_| |_|_| |_|\__, |
--                                                                       |___/
-- ********************************* @author davidk55 *******************************

local awful = require("awful")
local config = require("modules.config")

-- ================ AUTORUN APPLICATIONS ================
local autorun = true
local autorunApps = {
  "obsidian",
  "mailspring",
  "redshift",
  "keepassxc",
  "nextcloud",
  "kitty --title dev -e tmux",
  "spotify",
  "udiskie",
  "blueman-manager",
  "dolphin",
}
if autorun then
  print(autorun)
  for app = 1, #autorunApps do
    awful.spawn(autorunApps[app], { tag = " " })
  end
  awful.spawn("firefox", { tag = " " })
end
