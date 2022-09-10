-- **********************************************************************************
--                                                                  __ _
--   __ ___      _____  ___  ___  _ __ ___   ___    ___ ___  _ __  / _(_) __ _
--  / _` \ \ /\ / / _ \/ __|/ _ \| '_ ` _ \ / _ \  / __/ _ \| '_ \| |_| |/ _` |
-- | (_| |\ V  V /  __/\__ \ (_) | | | | | |  __/ | (_| (_) | | | |  _| | (_| |
--  \__,_| \_/\_/ \___||___/\___/|_| |_| |_|\___|  \___\___/|_| |_|_| |_|\__, |
--                                                                       |___/
-- ********************************* @author davidk55 *******************************

local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local theme = {}

-- ================ GENERAL ================

-- Colors
theme.bg_normal = "#282828"
theme.bg_focus = "#282828"
theme.bg_urgent = "#282828"
theme.bg_minimize = "#282828"
theme.bg_systray = "#282828"

theme.fg_normal = "#ebdbb2"
theme.fg_focus = "#ebdbb2"
theme.fg_urgent = "#6791c9"
theme.fg_minimize = "#6791c9"

-- Font
theme.font = "Hack Nerd Font 12"

-- Gaps
theme.useless_gap = dpi(12)

-- Border
theme.border_width = dpi(3)
theme.border_normal = "#282828"
theme.border_focus = "#ebdbb2"
theme.border_marked = "#ebdbb2"

-- Wallpaper
theme.wallpaper = "/home/david/.local/share/backgrounds/2.jpg"

-- ================ TAGLIST ================
theme.taglist_fg_focus = "#ebdbb2"
theme.taglist_fg_empty = "#54534e"
theme.taglist_fg_occupied = "#54534e"

theme.taglist_font = "Font Awesome 6 Free Solid 8"
theme.taglist_spacing = 5

-- ================ TASKLIST ================
theme.tasklist_fg_normal = "#54534e"
theme.tasklist_fg_focus = "#ebdbb2"
theme.tasklist_fg_minimize = "#6791c9"

theme.tasklist_disable_icon = true
theme.tasklist_align = "center"

-- ================ HOTKEYS_POPUP ================
theme.hotkeys_bg = "#000000"

return theme
