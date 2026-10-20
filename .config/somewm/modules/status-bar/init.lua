-- **********************************************************************************
--                                               __ _
--   ___  ___  _ __ ___   ___    ___ ___  _ __  / _(_) __ _
-- / __|/ _ \| '_ ` _ \ / _ \  / __/ _ \| '_ \| |_| |/ _` |
-- \__ \ (_) | | | | | |  __/ | (_| (_) | | | |  _| | (_| |
-- |___/\___/|_| |_| |_|\___|  \___\___/|_| |_|_| |_|\__, |
--                                                   |___/
-- ********************************* @author davidk55 *******************************

local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local volume_widget = require("modules.awesome-wm-widgets.volume-widget.volume")
local config = require("modules.config")

-- ================ TEXTCLOCK ================
local text_clock = wibox.widget.textclock("%a   %b. %d   %H:%M  ")
text_clock.font = "SFNS Display 14"

-- ================ SEPARATOR ================

local function separator()
  return wibox.widget({
    {
      orientation = "vertical",
      forced_width = 1,
      widget = wibox.widget.separator,
      color = "#282828",
    },
    top = 6,
    bottom = 6,
    left = 8,
    right = 8,
    widget = wibox.container.margin,
  })
end

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
    awful.button({}, 1, function()
      awful.layout.inc(1)
    end),
    awful.button({}, 3, function()
      awful.layout.inc(-1)
    end),
    awful.button({}, 4, function()
      awful.layout.inc(1)
    end),
    awful.button({}, 5, function()
      awful.layout.inc(-1)
    end)
  ))

  -- ================ TAGLIST ================
  awful.tag({ " \u{f111} ", " \u{f111} ", " \u{f111} ", " \u{f111} ", " \u{f111} " }, s, awful.layout.layouts[1])

  s.mytaglist = awful.widget.taglist({
    screen = s,
    filter = awful.widget.taglist.filter.all,
    buttons = {
      awful.button({}, 1, function(t)
        t:view_only()
      end),
      awful.button({ config.modkey }, 1, function(t)
        if client.focus then
          client.focus:move_to_tag(t)
        end
      end),
      awful.button({}, 3, awful.tag.viewtoggle),
      awful.button({}, 4, function(t)
        awful.tag.viewprev(t.screen)
      end),
      awful.button({}, 5, function(t)
        awful.tag.viewnext(t.screen)
      end),
    },
  })

  -- ================ TASKLIST ================
  s.mytasklist = awful.widget.tasklist({
    screen = s,
    filter = awful.widget.tasklist.filter.currenttags,
  })

  -- ================ WIBOX ================
  s.mywibox = awful.wibar({
    screen = s,
    height = 40,
    shape = custom_shape,
    margins = {
      top = 10,
      right = 20,
      left = 20,
      bottom = 4,
    },
  })

  -- ================ WIDGETS ================
  s.mywibox:setup({
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      separator(),
      layout = wibox.layout.fixed.horizontal,
      s.mytaglist,
      s.mypromptbox,
    },
    s.mytasklist, -- Middle widget
    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      -- order: left, right, top, bottom
      wibox.container.margin(wibox.widget.systray(), 3, 3, 3, 3),
      separator(),
      volume_widget({
        widget_type = "icon_and_text",
        font = "SFNS Display 12",
      }),
      separator(),
      text_clock,
      separator(),
    },
  })
end)
