-- **********************************************************************************
--                                                                  __ _
--   __ ___      _____  ___  ___  _ __ ___   ___    ___ ___  _ __  / _(_) __ _
--  / _` \ \ /\ / / _ \/ __|/ _ \| '_ ` _ \ / _ \  / __/ _ \| '_ \| |_| |/ _` |
-- | (_| |\ V  V /  __/\__ \ (_) | | | | | |  __/ | (_| (_) | | | |  _| | (_| |
--  \__,_| \_/\_/ \___||___/\___/|_| |_| |_|\___|  \___\___/|_| |_|_| |_|\__, |
--                                                                       |___/
-- ********************************* @author davidk55 *******************************

local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

local volume_widget = require("awesome-wm-widgets.volume-widget.volume")
local spotify_widget = require("awesome-wm-widgets.spotify-widget.spotify")

-- ================ TEXTCLOCK ================
local text_clock = wibox.widget.textclock("%a   %b. %d   %H:%M  ")
text_clock.font = "SFNS Display 16"

-- ================ SEPARATOR ================
local separator = wibox.widget.textbox("   ")

-- ================ CUSTOM SHAPES ================
local function custom_shape(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 10)
end

-- ================ DRAW WIBAR ================
awful.screen.connect_for_each_screen(function(s)

    -- ================ PROMPTBOX ================
    s.mypromptbox = awful.widget.prompt()

    -- ================ LAYOUTBOX ================
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
        awful.button({}, 1, function() awful.layout.inc(1) end),
        awful.button({}, 3, function() awful.layout.inc(-1) end),
        awful.button({}, 4, function() awful.layout.inc(1) end),
        awful.button({}, 5, function() awful.layout.inc(-1) end)
    ))

    -- ================ TAGLIST ================
    awful.tag({ " \u{f111} ", " \u{f111} ", " \u{f111} ", " \u{f111} ", " " },
        s, awful.layout.layouts[1])

    s.mytaglist = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
    }

    -- ================ TASKLIST ================
    s.mytasklist = awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
    }

    -- ================ WIBOX ================
    s.mywibox = awful.wibar({
        screen = s,
        height = 35,
        width = 1880,
        shape = custom_shape
    })
    s.mywibox.y = 10

    -- ================ WIDGETS ================
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            separator,
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            -- order: left, right, top, bottom
            wibox.container.margin(wibox.widget.systray(), 8, 8, 8, 8),
            separator,
            wibox.container.margin(spotify_widget({
                play_icon = "/home/david/.config/awesome/awesome-wm-widgets/spotify-widget/icons/spotify-running.svg",
                pause_icon = "/home/david/.config/awesome/awesome-wm-widgets/spotify-widget/icons/spotify-pause.svg",
                font = "SFNS Display 14",
                max_length = 40;
                dim_when_paused = true,
                dim_opacity = 0.5
            }), 6, 6, 6, 6),
            separator,
            volume_widget {
                widget_type = "icon_and_text",
                font = "SFNS Display 14"
            },
            separator,
            text_clock,
            separator,
        },
    }
end)

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
