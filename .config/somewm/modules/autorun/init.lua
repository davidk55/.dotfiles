-- **********************************************************************************
--                                               __ _
--   ___  ___  _ __ ___   ___    ___ ___  _ __  / _(_) __ _
-- / __|/ _ \| '_ ` _ \ / _ \  / __/ _ \| '_ \| |_| |/ _` |
-- \__ \ (_) | | | | | |  __/ | (_| (_) | | | |  _| | (_| |
-- |___/\___/|_| |_| |_|\___|  \___\___/|_| |_|_| |_|\__, |
--                                                   |___/
-- ********************************* @author davidk55 *******************************

local awful = require("awful")

-- ================ AUTORUN APPLICATIONS ================
local autorun = true
local appsToLaunch = {
  "obsidian",
  "thunderbird",
  "keepassxc",
  "nextcloud",
  "kitty --title dev",
  "blueman-applet",
  "dolphin",
  "/home/david/Nextcloud/Main/Further-Dotfiles/scripts/connect-bt-headphones",
  "solaar --window hide --battery-icons solaar --tray-icon-size=32",
  "redshift -c /home/david/Nextcloud/Main/Further-Dotfiles/config/redshift/redshift.conf",
  "copyq",
  "focus-timer",
  "qalculate-gtk",
  "floorp",
  "anki",
}
local scriptsToRun = {
  "dunst",
  "sleep 5 && /home/david/bin/awesome-startup",
  'somewm-client wallpaper set "$(find ~/Nextcloud/Main/Further-Dotfiles/Backgrounds -type f | shuf -n 1)"',
  'eval "$(ssh-agent)"',
}

if autorun then
  for current_app = 1, #appsToLaunch do
    awful.spawn(appsToLaunch[current_app])
  end
  for current_script = 1, #scriptsToRun do
    awful.spawn.with_shell(scriptsToRun[current_script])
  end
end
