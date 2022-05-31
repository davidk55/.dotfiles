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
local autorunApps =
{
    "discord",
    "obsidian",
    "thunderbird",
    "redshift",
    "keepassxc",
    "nextcloud",
    config.terminal .. " -t term -e util-tmux",
    "kitty --title dev",
    "spotify"
}
if autorun then
    print(autorun)
    for app = 1, #autorunApps do
        awful.spawn(autorunApps[app], { tag = " " })
    end
    awful.spawn("firefox --new-window nc:8080", {
    })
end

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
