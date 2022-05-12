-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus") -- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- Widgets
local volume_widget = require("awesome-wm-widgets.volume-widget.volume")
local spotify_widget = require("awesome-wm-widgets.spotify-widget.spotify")


--------------------------- ERROR HANDLING ------------------------------
-- {{{
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

--------------------------- VARIABLE DEFINITIONS ------------------------------
-- {{{
-- Themes define colours, icons, font and wallpapers.
beautiful.init("/home/david/.config/awesome/themes/my_theme/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "alacritty"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    -- awful.layout.suit.floating,
    awful.layout.suit.tile,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

--------------------------- MENU ------------------------------
-- {{{
-- Create a launcher widget and a main menu
-- myawesomemenu = {
--   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
--   { "manual", terminal .. " -e man awesome" },
--   { "edit config", editor_cmd .. " " .. awesome.conffile },
--   { "restart", awesome.restart },
--   { "quit", function() awesome.quit() end },
--}

--mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
--                                    { "open terminal", terminal }
--                                  }
--                        })

--mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
--                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}


--------------------------- WIBAR ------------------------------
-- {{{
-- Create a textclock widget
mytextclock = wibox.widget.textclock("%a   %b. %d   %H:%M  ")
mytextclock.font = "SFNS Display 16"
-- Create Separator widget
local separator = wibox.widget.textbox("   ")


-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ " \u{f059} ", " \u{e007} ", " \u{f186} ",  " \u{f084} ", " \u{f121} ", " \u{f002} ", " \u{f120} ", " \u{f0e0} ", " \u{f04b} ", " \u{f392} " }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }

    -- Create the wibox
    s.mywibox = awful.wibar({
        screen = s,
        height = 28,
    })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            -- order left, right, top, bottom
            wibox.container.margin(wibox.widget.systray(), 4, 4, 4, 4),
            separator,
            spotify_widget ({
              play_icon = "/home/david/.config/awesome/awesome-wm-widgets/spotify-widget/icons/spotify-running.svg",
              pause_icon = "/home/david/.config/awesome/awesome-wm-widgets/spotify-widget/icons/spotify-pause.svg",
              font = "SFNS Display 14",
              dim_when_paused = true,
              dim_opacity = 0.5
            }),
            separator,
            volume_widget {
              widget_type = "icon_and_text",
              font = "SFNS Display 14"
            },
            separator,
            mytextclock,
            separator,
            s.mylayoutbox,
        },
    }
end)
-- }}}

--------------------------- KEYBOARD SHORTCUTS ------------------------------
-- {{{
globalkeys = gears.table.join(
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey,           }, ",", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen 2", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
--    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
--              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Rofi-Prompt
    awful.key({ }, "#138",     function () awful.util.spawn("rofi -show drun") end,
              {description = "run rofi-prompt", group = "launcher"}),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    -- Rofi-Calculator
    awful.key({ }, "#148",     function () awful.util.spawn("rofi -show calc -modi calc -no-show-match -no-sort -no-persist-history -calc-command 'echo -n '{result}' | xclip -sel clip'") end,
              {description = "run rofi-calculator", group = "launcher"}),
    -- Rofi-Emoji-Selector
    awful.key({ }, "#142",     function () awful.util.spawn("rofi -show emoji -modi emoji") end,
              {description = "run rofi-emoji-selector", group = "launcher"}),
    -- Rofi-Power-Menu
    awful.key({ }, "#191",     function () awful.util.spawn("rofi -show p -modi p:rofi-power-menu") end,
              {description = "run rofi-emoji-selector", group = "launcher"}),
    -- Menubar
    awful.key({ modkey }, "t", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"}),
    -- Volume down
    awful.key({ }, "#122", function() volume_widget:dec(5) end,
              {description = "lower the volume", group = "volume"}),
    -- Volume up
    awful.key({ }, "#123", function() volume_widget:inc(5) end,
              {description = "upper the volume", group = "volume"}),
    -- Toggle mute/unmute
    awful.key({ }, "#121", function() volume_widget:toggle() end,
              {description = "toggle mute/unmute", group = "volume"})
)

clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey,           }, ".", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey, "Shift"   }, ",",       function (c) 
                                                    local index = c.first_tag.index
                                                    c:move_to_screen()
                                                    local tag = c.screen.tags[index]
                                                    c:move_to_tag(tag)
                                                end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
)


function toggleTagAndFocusName(tag_idx, _name)
    local screenToSkip
    for _,c in ipairs(client.get()) do
        if (c.name == _name) then
            screenToSkip = c.screen
        end
    end
    for s in screen do
      if (not (s == screenToSkip)) then
          awful.tag.viewtoggle(s.tags[tag_idx])
      end
    end
    if (screenToSkip ~= nil) then
        awful.tag.viewtoggle(screenToSkip.tags[tag_idx])
        awful.screen.focus(screenToSkip.index)
        for _,c in ipairs(screenToSkip.clients) do
            if awful.rules.match(c, {name = _name}) then
                awful.screen.focus(screenToSkip.index)
                client.focus = c
                return
            end
        end
    end
end
function toggleTagAndFocusClass(tag_idx, _class)
    local screenToSkip
    for _,c in ipairs(client.get()) do
        if (c.class == _class) then
            screenToSkip = c.screen
        end
    end
    for s in screen do
      if (not (s == screenToSkip)) then
          awful.tag.viewtoggle(s.tags[tag_idx])
      end
    end
    if (screenToSkip ~= nil) then
        awful.tag.viewtoggle(screenToSkip.tags[tag_idx])
        awful.screen.focus(screenToSkip.index)
        for _,c in ipairs(screenToSkip.clients) do
            if awful.rules.match(c, {class = _class}) then
                awful.screen.focus(screenToSkip.index)
                client.focus = c
                return
            end
        end
    end
end
function toggleTagAndFocusInstance(tag_idx, _instance)
    local screenToSkip
    for _,c in ipairs(client.get()) do
        if (c.instance == _instance) then
            screenToSkip = c.screen
        end
    end
    for s in screen do
      if (not (s == screenToSkip)) then
          awful.tag.viewtoggle(s.tags[tag_idx])
      end
    end
    if (screenToSkip ~= nil) then
        awful.tag.viewtoggle(screenToSkip.tags[tag_idx])
        awful.screen.focus(screenToSkip.index)
        for _,c in ipairs(screenToSkip.clients) do
            if awful.rules.match(c, {instance = _instance}) then
                awful.screen.focus(screenToSkip.index)
                client.focus = c
                return
            end
        end
    end
end
function moveClientToTag(tag_idx)
    if client.focus then
        local tag = client.focus.screen.tags[tag_idx]
        if tag then
            client.focus:move_to_tag(tag)
        end
    end
end
globalkeys = gears.table.join(globalkeys,

-- Toggle specific tags

    -- Toggle firefox tag
    awful.key({ modkey }, "i", function () toggleTagAndFocusClass(2, "firefox") end,
    {description = "toggle firefox tag", group = "tag"}),

    -- Toggle note tag
    awful.key({ modkey }, "o", function () toggleTagAndFocusClass(3, "obsidian") end,
    {description = "toggle notes tag", group = "tag"}),

    -- Toggle pw tag
    awful.key({ modkey }, "p", function () toggleTagAndFocusClass(4, "KeePassXC") end,
    {description = "toggle passwords tag", group = "tag"}),

    -- Toggle dev tag
    awful.key({ modkey }, ";", function () toggleTagAndFocusName(5, "dev") end,
    {description = "toggle coding tag", group = "tag"}),

    -- Toggle devdocs tag
    awful.key({ modkey }, "d", function () toggleTagAndFocusClass(6, "Devdocs-desktop") end,
    {description = "toggle devdocs tag", group = "tag"}),

    -- Toggle term tag
    awful.key({ modkey }, "'", function() toggleTagAndFocusName(7, "term") end,
    {description = "toggle terminal tag", group = "tag"}),

    -- Toggle email tag
    awful.key({ modkey }, "u", function () toggleTagAndFocusClass(8, "Thunderbird") end,
    {description = "toggle email tag", group = "tag"}),

    -- Toggle music tag
    awful.key({ modkey }, "[", function () toggleTagAndFocusClass(9, "firefox") end,
    {description = "toggle music tag", group = "tag"}),

    -- Toggle discord tag
    awful.key({ modkey }, "]", function () toggleTagAndFocusInstance(10, "discord") end,
    {description = "toggle discord tag", group = "tag"}),

-- Move clients to specific tags

    -- Move firefox tag
    awful.key({ modkey, "Shift" }, "i", function () moveClientToTag(2) end,
    {description = "move to firefox tag", group = "tag"}),

    -- Move to note tag
    awful.key({ modkey, "Shift" }, "o", function () moveClientToTag(3) end,
    {description = "move to notes tag", group = "tag"}),

    -- Move to pw tag
    awful.key({ modkey, "Shift" }, "p", function () moveClientToTag(4) end,
    {description = "move to passwords tag", group = "tag"}),

    -- Move to code tag
    awful.key({ modkey, "Shift" }, ";", function () moveClientToTag(5) end,
    {description = "move to coding tag", group = "tag"}),

    -- Move to devdocs tag
    awful.key({ modkey, "Shift" }, "d", function () moveClientToTag(6) end,
    {description = "move to devdocs tag", group = "tag"}),

    -- Move to dir tag
    awful.key({ modkey, "Shift" }, "'", function () moveClientToTag(7) end,
    {description = "move to terminal tag", group = "tag"}),

    -- Move to email tag
    awful.key({ modkey, "Shift" }, "u", function () moveClientToTag(8) end,
    {description = "move to email tag", group = "tag"}),

    -- Move to music tag
    awful.key({ modkey, "Shift" }, "[", function () moveClientToTag(9) end,
    {description = "move to music tag", group = "tag"}),

    -- Move to discord tag
    awful.key({ modkey, "Shift" }, "]", function () moveClientToTag(10) end,
    {description = "move to discord tag", group = "tag"})
)

for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View specific tag
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        for s in screen do
                            local tag = s.tags[i]
                            if tag then
                               tag:view_only()
                            end
                        end
                  end,
                  {description = "view tag #" .. i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                      end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set the keys
root.keys(globalkeys)
-- }}}


--------------------------- RULES --------------------------------
-- {{{
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer",
          "Steam",
          "qView",
          "Devdocs-desktop"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = false }
    },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
     { rule = { class = "Devdocs-desktop" },
       properties = { tag = " \u{f002} ", screen = 1 } },
     { rule = { class = "firefox" },
       properties = { tag = " \u{e007} ", screen = 2 } },
     { rule = { class = "obsidian" },
       properties = { tag = " \u{f186} ", screen = 2 } },
     { rule = { class = "KeePassXC" },
       properties = { tag = " \u{f084} ", screen = 2 } },
     { rule = { class = "Thunderbird" },
       properties = { tag = " \u{f0e0} ", screen = 2 } },
     { rule = { instance = "discord" },
       properties = { tag = " \u{f392} ", screen = 2 } },
     { rule = { name = "dev" },
       properties = { tag = " \u{f121} ", screen = 1 } },
     { rule = { name = "term" },
       properties = { tag = " \u{f120} ", screen = 1 } },
     { rule = { class = "okular" },
       properties = { tag = " \u{f07c} ", screen = 2 } },
}
-- }}}

--------------------------- SIGNALS --------------------------------
-- {{{
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}


--------------------------- AUTORUN --------------------------------
-- {{{
autorun = true
autorunApps =
{
    "discord",
    "obsidian",
    "thunderbird",
    "redshift",
    "keepassxc",
    "nextcloud",
    "devdocs-desktop",
    "alacritty -t term -e util-tmux",
    "alacritty -t dev",
}
if autorun then
    for app = 1, #autorunApps do
        awful.spawn(autorunApps[app])
    end
end

awful.spawn("firefox --new-window nc:8080", {
    tag = " \u{e007} ",
    screen = 2,
})
-- }}}
