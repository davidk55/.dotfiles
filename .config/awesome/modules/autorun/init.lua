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
  "keepassxc",
  "nextcloud",
  "kitty --title dev",
  "blueman-manager",
  "/home/david/Nextcloud/Main/Further-Dotfiles/scripts/connect-bt-headphones",
  "solaar -w hide",
  "redshift -c /home/david/Nextcloud/Main/Further-Dotfiles/config/redshift/redshift.conf",
}
if autorun then
  for app = 1, #autorunApps do
    awful.spawn(autorunApps[app])
  end
  awful.spawn("floorp")
end
