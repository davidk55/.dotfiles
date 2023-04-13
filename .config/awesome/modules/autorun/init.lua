-- **********************************************************************************
--                                                                  __ _
--   __ ___      _____  ___  ___  _ __ ___   ___    ___ ___  _ __  / _(_) __ _
--  / _` \ \ /\ / / _ \/ __|/ _ \| '_ ` _ \ / _ \  / __/ _ \| '_ \| |_| |/ _` |
-- | (_| |\ V  V /  __/\__ \ (_) | | | | | |  __/ | (_| (_) | | | |  _| | (_| |
--  \__,_| \_/\_/ \___||___/\___/|_| |_| |_|\___|  \___\___/|_| |_|_| |_|\__, |
--                                                                       |___/
-- ********************************* @author davidk55 *******************************

local awful = require("awful")

-- ================ AUTORUN APPLICATIONS ================
local autorun = true
local autorunApps = {
  "obsidian",
  "mailspring",
  "redshift",
  "keepassxc",
  "nextcloud",
  "kitty --title dev -e /home/david/Nextcloud/Sync/bin/pokemon/showpoke",
  "spotify",
  "udiskie",
  "blueman-manager",
  "dolphin",
  "psensor",
}
if autorun then
  for app = 1, #autorunApps do
    awful.spawn(autorunApps[app])
  end
  awful.spawn("firefox")
end
