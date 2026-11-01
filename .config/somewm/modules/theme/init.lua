-- **********************************************************************************
--                                               __ _
--   ___  ___  _ __ ___   ___    ___ ___  _ __  / _(_) __ _
-- / __|/ _ \| '_ ` _ \ / _ \  / __/ _ \| '_ \| |_| |/ _` |
-- \__ \ (_) | | | | | |  __/ | (_| (_) | | | |  _| | (_| |
-- |___/\___/|_| |_| |_|\___|  \___\___/|_| |_|_| |_|\__, |
--                                                   |___/
-- ********************************* @author davidk55 *******************************

require("somewm.animation").enabled = true
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
theme.systray_menu_border_color = "#54534e"
theme.systray_menu_width = dpi(350)
theme.systray_menu_font = "Hack Nerd Font 9"
theme.systray_menu_bg_focus = "#ebdbb2"
theme.systray_menu_fg_focus = "#282828"
theme.systray_menu_border_width = dpi(1)

theme.fg_normal = "#ebdbb2"
theme.fg_focus = "#ebdbb2"
theme.fg_urgent = "#6791c9"
theme.fg_minimize = "#6791c9"

-- Font
theme.font = "Hack Nerd Font 11"

-- Gaps
theme.useless_gap = dpi(6)

-- Border
theme.border_width = dpi(3)
theme.border_normal = "#282828"
theme.border_focus = "#ebdbb2"
theme.border_marked = "#ebdbb2"

-- ================ TAGLIST ================
theme.taglist_fg_focus = "#ebdbb2"
theme.taglist_fg_empty = "#54534e"
theme.taglist_fg_occupied = "#54534e"

theme.taglist_font = "Font Awesome 6 Free Solid 8"
theme.taglist_spacing = 8

-- ================ TASKLIST ================
theme.tasklist_fg_normal = "#54534e"
theme.tasklist_fg_focus = "#ebdbb2"
theme.tasklist_fg_minimize = "#6791c9"

theme.tasklist_disable_icon = true
theme.tasklist_align = "center"

-- ================ HOTKEYS_POPUP ================
theme.hotkeys_bg = "#000000"

theme.menu_height = dpi(15)
theme.menu_width = dpi(100)

-- ================ ANIMATIONS ================
-- Window movement / tiling animations
theme.animation_layout_duration = 0.18

-- Opening and closing windows
theme.animation_appear = { "fade", "scale" }
theme.animation_appear_duration = 0.20

theme.animation_disappear = { "fade", "scale" }
theme.animation_disappear_duration = 0.15

-- Workspace (tag) switches
theme.animation_tag = "fade"
theme.animation_tag_duration = 0.18

-- Maximize / restore
theme.animation_maximize_duration = 0.20

-- Floating / tiling transitions
theme.animation_floating_duration = 0.18

-- Focus border transitions
theme.animation_focus_duration = 0.12

return theme
