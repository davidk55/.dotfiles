--------------------------------
--  "my_theme" awesome theme  --
--  By David "NayzR" Köhlmann --
--------------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local themes_path = "/home/david/.config/awesome/themes/"


-- BASICS
local theme = {}
theme.font          = "Hack Nerd Font 12"

theme.taglist_bg_focus      = "#262626c0"
theme.bg_focus      = "#262626c0"
theme.bg_normal     = "#28282800"
theme.bg_urgent     = "#28282800"
theme.bg_minimize   = "#2c2123d0"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#ebdbb2"
theme.fg_focus      = "#ebdbb2"
theme.fg_urgent     = "#ebdbb2"
theme.fg_minimize   = "#ebdbb2"

theme.useless_gap   = dpi(10)
theme.border_width  = dpi(2)
theme.border_normal = "#292824"
theme.border_focus  = "#729fcf"
theme.border_marked = "#eeeeec"
theme.border_focus = "#ebdbb2"

-- IMAGES
theme.layout_fairh           = themes_path .. "my_theme/layouts/fairh.png"
theme.layout_fairv           = themes_path .. "my_theme/layouts/fairv.png"
theme.layout_floating        = themes_path .. "my_theme/layouts/floating.png"
theme.layout_magnifier       = themes_path .. "my_theme/layouts/magnifier.png"
theme.layout_max             = themes_path .. "my_theme/layouts/max.png"
theme.layout_fullscreen      = themes_path .. "my_theme/layouts/fullscreen.png"
theme.layout_tilebottom      = themes_path .. "my_theme/layouts/tilebottom.png"
theme.layout_tileleft        = themes_path .. "my_theme/layouts/tileleft.png"
theme.layout_tile            = themes_path .. "my_theme/layouts/tile.png"
theme.layout_tiletop         = themes_path .. "my_theme/layouts/tiletop.png"
theme.layout_spiral          = themes_path .. "my_theme/layouts/spiral.png"
theme.layout_dwindle         = themes_path .. "my_theme/layouts/dwindle.png"
theme.layout_cornernw        = themes_path .. "my_theme/layouts/cornernw.png"
theme.layout_cornerne        = themes_path .. "my_theme/layouts/cornerne.png"
theme.layout_cornersw        = themes_path .. "my_theme/layouts/cornersw.png"
theme.layout_cornerse        = themes_path .. "my_theme/layouts/cornerse.png"

-- theme.awesome_icon           = themes_path .. "my_theme/awesome-icon.png"

-- from default for now...
theme.menu_submenu_icon     = themes_path .. "default/submenu.png"

-- Generate taglist squares:
--local taglist_square_size = dpi(4)
--theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
--    taglist_square_size, theme.fg_normal
--)
--theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
--    taglist_square_size, theme.fg_normal
--)

-- TAGLIST
theme.taglist_font = "Hack Nerd Font 14"
theme.taglist_spacing = 0

-- TASKLIST
theme.tasklist_disable_icon = true
theme.tasklist_align = "center"
theme.tasklist_font = "Hack Nerd Font 10"

-- MISC
theme.wallpaper             = "/home/david/.local/share/bgs/bg1.jpg"
theme.taglist_squares       = "true"
theme.titlebar_close_button = "true"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)
theme.hotkeys_modifiers_fg = "#6D5357"

-- Define the image to load
theme.titlebar_close_button_normal = themes_path .. "default/titlebar/close_normal.png"
theme.titlebar_close_button_focus = themes_path .. "default/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = themes_path .. "default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = themes_path .. "default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = themes_path .. "default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive = themes_path .. "default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path .. "default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active = themes_path .. "default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path .. "default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive = themes_path .. "default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path .. "default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active = themes_path .. "default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path .. "default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive = themes_path .. "default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path .. "default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active = themes_path .. "default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path .. "default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive = themes_path .. "default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themes_path .. "default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active = themes_path .. "default/titlebar/maximized_focus_active.png"

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
