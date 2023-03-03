-- **********************************************************************************
--                                                                  __ _
--   __ ___      _____  ___  ___  _ __ ___   ___    ___ ___  _ __  / _(_) __ _
--  / _` \ \ /\ / / _ \/ __|/ _ \| '_ ` _ \ / _ \  / __/ _ \| '_ \| |_| |/ _` |
-- | (_| |\ V  V /  __/\__ \ (_) | | | | | |  __/ | (_| (_) | | | |  _| | (_| |
--  \__,_| \_/\_/ \___||___/\___/|_| |_| |_|\___|  \___\___/|_| |_|_| |_|\__, |
--                                                                       |___/
-- ********************************* @author davidk55 *******************************

local awful = require("awful")
local gears = require("gears")
local hotkeys_popup = require("awful.hotkeys_popup")
local config = require("modules.config")
local toggle_clients = require("modules.toggle-clients")
local volume_widget = require("modules.awesome-wm-widgets.volume-widget.volume")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local shortcuts = {}
local eww_is_open = false
local toggleable_applications = {
  class = {
    "firefox",
    "obsidian",
    "KeePassXC",
    "dolphin",
    "Mailspring",
    "Spotify",
    "Anki",
    "Psensor",
    "Blueman-manager",
  },
  name = {
    "dev",
    "pulsemixer",
  },
  instance = { "discord", "jetbrains-idea" },
}

-- ================ GENERAL ================

shortcuts.globalkeys = gears.table.join(
  -- Hotkey popup
  awful.key({ config.modkey }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome: general" }),

  -- Focus the next screen (by index)
  awful.key({ config.modkey }, ",", function()
    awful.screen.focus_relative(1)
  end, { description = "focus the next screen", group = "awesome: general" }),

  -- Open a terminal
  awful.key({ config.modkey }, "Return", function()
    awful.spawn(config.terminal)
  end, { description = "open a terminal", group = "awesome: general" }),

  -- Restart awesome
  awful.key(
    { config.modkey, "Control" },
    "r",
    awesome.restart,
    { description = "reload awesome", group = "awesome: general" }
  ),

  -- Quit awesome
  awful.key({ config.modkey, "Shift" }, "q", awesome.quit, { description = "quit awesome", group = "awesome: general" }),

  -- Increase master width
  awful.key({ config.modkey }, "l", function()
    awful.tag.incmwfact(0.05)
  end, { description = "increase master width factor", group = "awesome: layout" }),

  -- Decrease master width
  awful.key({ config.modkey }, "h", function()
    awful.tag.incmwfact(-0.05)
  end, { description = "decrease master width factor", group = "awesome: layout" }),

  -- Increase the number of master clients
  awful.key({ config.modkey, "Shift" }, "h", function()
    awful.tag.incnmaster(1, nil, true)
  end, { description = "increase the number of master clients", group = "awesome: layout" }),

  -- Decrease the number of master clients
  awful.key({ config.modkey, "Shift" }, "l", function()
    awful.tag.incnmaster(-1, nil, true)
  end, { description = "decrease the number of master clients", group = "awesome: layout" }),

  -- Increase the number of columns
  awful.key({ config.modkey, "Control" }, "h", function()
    awful.tag.incncol(1, nil, true)
  end, { description = "increase the number of columns", group = "awesome: layout" }),

  -- Decrease the number of columns
  awful.key({ config.modkey, "Control" }, "l", function()
    awful.tag.incncol(-1, nil, true)
  end, { description = "decrease the number of columns", group = "awesome: layout" }),

  -- Selects next layout
  awful.key({ config.modkey }, "space", function()
    awful.layout.inc(1)
  end, { description = "select next", group = "awesome: layout" }),

  -- Select previous layout
  awful.key({ config.modkey, "Shift" }, "space", function()
    awful.layout.inc(-1)
  end, { description = "select previous", group = "awesome: layout" }),

  -- Toggle the wibar
  awful.key({ config.modkey }, "w", function()
    for s in screen do
      s.mywibox.visible = not s.mywibox.visible
    end
  end, { description = "toggle the wibar", group = "awesome: general" }),

  -- Toggle gaps
  awful.key({ config.modkey }, "g", function()
    if beautiful.useless_gap == 0 then
      beautiful.useless_gap = dpi(12)
    else
      beautiful.useless_gap = 0
    end
    for s in screen do
      awful.layout.arrange(s)
    end
  end, { description = "toggle gaps", group = "awesome: general" }),

  -- Toggle distraction free
  awful.key({ config.modkey }, "=", function()
    if beautiful.useless_gap == 0 then
      beautiful.useless_gap = dpi(12)
      for _, c in ipairs(client.get()) do
        c.border_width = 3
      end
      for s in screen do
        s.mywibox.visible = true
      end
    else
      beautiful.useless_gap = 0
      for _, c in ipairs(client.get()) do
        c.border_width = 2
      end
      for s in screen do
        s.mywibox.visible = false
      end
    end

    for s in screen do
      awful.layout.arrange(s)
    end
  end, { description = "toggle gaps", group = "awesome: general" }),

  -- Toggle opacity
  awful.key({ config.modkey }, "-", function()
    os.execute("picom-trans --toggle")
  end),
  -- Hide all clients
  awful.key({ config.modkey }, "x", function()
    for _, c in ipairs(client.get()) do
      c.hidden = true
    end
  end),
  -- Unhide all non toggleable clients
  awful.key({ config.modkey }, "z", function()
    for _, c in ipairs(client.get()) do
      local is_toggleable = false
      for _, name in ipairs(toggleable_applications.name) do
        if c.name == name then
          is_toggleable = true
        end
      end
      for _, class in ipairs(toggleable_applications.class) do
        if c.class == class then
          is_toggleable = true
        end
      end
      for _, instance in ipairs(toggleable_applications.instance) do
        if c.instance == instance then
          is_toggleable = true
        end
      end
      if not is_toggleable then
        c.hidden = false
      end
    end
  end),

  awful.key({ config.modkey }, "e", function()
    if eww_is_open then
      os.execute("eww open-many profile uptime github youtube")
    else
      os.execute("eww close profile uptime github youtube")
    end
    eww_is_open = not eww_is_open
  end)
)

-- ================ TAGS ================
for i = 1, 5 do
  shortcuts.globalkeys = gears.table.join(
    shortcuts.globalkeys,
    -- View specific tag
    awful.key({ config.modkey }, "#" .. i + 9, function()
      for s in screen do
        local tag = s.tags[i]
        if tag then
          tag:view_only()
        end
      end
    end, { description = "view tag #" .. i, group = "awesome: tags" }),

    -- Toggle tag display.
    awful.key({ config.modkey, "Control" }, "#" .. i + 9, function()
      local screen = awful.screen.focused()
      local tag = screen.tags[i]
      if tag then
        awful.tag.viewtoggle(tag)
      end
    end, { description = "toggle tag #" .. i, group = "awesome: tags" }),

    -- Move client to tag.
    awful.key({ config.modkey, "Shift" }, "#" .. i + 9, function()
      if client.focus then
        local tag = client.focus.screen.tags[i]
        if tag then
          client.focus:move_to_tag(tag)
        end
      end
    end, { description = "move focused client to tag #" .. i, group = "awesome: tags" })
  )
end

-- ================ CLIENTS ================
shortcuts.clientkeys = gears.table.join(
  -- Make client fullscreen
  awful.key({ config.modkey }, "f", function(c)
    c.fullscreen = not c.fullscreen
    c:raise()
  end, { description = "toggle fullscreen", group = "awesome: clients" }),

  -- Kill current client
  awful.key({ config.modkey, "Shift" }, "c", function(c)
    c:kill()
  end, { description = "close", group = "awesome: clients" }),

  -- Toggle client floating
  awful.key(
    { config.modkey, "Control" },
    "space",
    awful.client.floating.toggle,
    { description = "toggle floating", group = "awesome: clients" }
  ),

  -- Make focused client master
  awful.key({ config.modkey }, ".", function(c)
    c:swap(awful.client.getmaster())
  end, { description = "move to master", group = "awesome: clients" }),

  -- Move focused client to next screen
  awful.key({ config.modkey, "Shift" }, ",", function(c)
    local index = c.first_tag.index
    c:move_to_screen()
    local tag = c.screen.tags[index]
    c:move_to_tag(tag)
  end, { description = "move to screen", group = "awesome: clients" }),

  -- Minimize focused client
  awful.key({ config.modkey }, "n", function(c)
    c.minimized = true
  end, { description = "minimize", group = "awesome: clients" }),

  -- Toggle maximize the focused client
  awful.key({ config.modkey }, "m", function(c)
    c.maximized = not c.maximized
    c:raise()
  end, { description = "(un)maximize", group = "awesome: clients" }),

  -- Toggle maximize the focused client vertically
  awful.key({ config.modkey, "Control" }, "m", function(c)
    c.maximized_vertical = not c.maximized_vertical
    c:raise()
  end, { description = "(un)maximize vertically", group = "awesome: clients" }),

  -- Toggle maximize the focused client horizontally
  awful.key({ config.modkey, "Shift" }, "m", function(c)
    c.maximized_horizontal = not c.maximized_horizontal
    c:raise()
  end, { description = "(un)maximize horizontally", group = "awesome: clients" }),

  -- Focus the next client (by index)
  awful.key({ config.modkey }, "j", function()
    awful.client.focus.byidx(1)
  end, { description = "focus next by index", group = "awesome: clients" }),

  -- Focus the previous client (by index)
  awful.key({ config.modkey }, "k", function()
    awful.client.focus.byidx(-1)
  end, { description = "focus previous by index", group = "awesome: clients" }),

  -- Swap with the next client (by index)
  awful.key({ config.modkey, "Shift" }, "j", function()
    awful.client.swap.byidx(1)
  end, { description = "swap with next client by index", group = "awesome: clients" }),

  -- Swap with the previous client (by index)
  awful.key({ config.modkey, "Shift" }, "k", function()
    awful.client.swap.byidx(-1)
  end, { description = "swap with previous client by index", group = "awesome: clients" }),

  -- Focus the last client (by focus)
  awful.key({ config.modkey }, "Tab", function()
    awful.client.focus.history.previous()
    if client.focus then
      client.focus:raise()
    end
  end, { description = "go back", group = "awesome: clients" }),

  -- Restore last minimized client
  awful.key({ config.modkey, "Control" }, "n", function()
    local c = awful.client.restore()
    -- Focus restored client
    if c then
      c:emit_signal("request::activate", "key.unminimize", { raise = true })
    end
  end, { description = "restore minimized", group = "awesome: clients" })
)

-- ================ MOUSE ================
shortcuts.clientbuttons = gears.table.join(
  awful.button({}, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
  end),
  awful.button({ config.modkey }, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.move(c)
  end),
  awful.button({ config.modkey }, 3, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.resize(c)
  end)
)

-- ================ TOGGLE APPLICATIONS ================
shortcuts.globalkeys = gears.table.join(
  shortcuts.globalkeys,
  -- Toggle firefox client
  awful.key({ config.modkey }, "i", function()
    toggle_clients({ class = "firefox" })
  end),

  -- Toggle obsidian client
  awful.key({ config.modkey }, "o", function()
    toggle_clients({ class = "obsidian" })
  end),

  -- Toggle keepass client
  awful.key({ config.modkey }, "p", function()
    toggle_clients({ class = "KeePassXC" })
  end),

  -- Toggle dev client
  awful.key({ config.modkey }, ";", function()
    toggle_clients({ name = "dev" })
  end),

  -- Toggle pdf viewer
  awful.key({ config.modkey }, "'", function()
    toggle_clients({ class = "dolphin" })
  end),

  -- Toggle e-mail client
  awful.key({ config.modkey }, "u", function()
    toggle_clients({ class = "Mailspring" })
  end),

  -- Toggle spotify client
  awful.key({ config.modkey }, "[", function()
    toggle_clients({ class = "Spotify" })
  end),

  -- Toggle discord client
  awful.key({ config.modkey }, "]", function()
    toggle_clients({ instance = "discord" })
  end),

  -- Toggle intellij client
  awful.key({ config.modkey }, "y", function()
    toggle_clients({ instance = "jetbrains-idea" })
  end),

  -- Toggle newsboat
  awful.key({ config.modkey }, "r", function()
    awful.spawn.easy_async(config.terminal .. " -e newsboat")
  end),

  -- Toggle anki
  awful.key({ config.modkey }, "a", function()
    toggle_clients({ class = "Anki" })
  end)
)

-- ================ ROFI ================
shortcuts.globalkeys = gears.table.join(
  shortcuts.globalkeys,
  -- Open rofi drun
  awful.key({}, "#202", function()
    awful.util.spawn("rofi -show drun -show-icons")
  end),

  -- Open rofi calculator
  awful.key({}, "#148", function()
    awful.util.spawn(
      "rofi -show calc -modi calc -no-show-match -no-sort -no-persist-history -calc-command 'echo -n '{result}' | xclip -sel clip'"
    )
  end),

  -- Open rofi emoji selector
  awful.key({}, "#193", function()
    awful.util.spawn("rofi -show emoji -modi emoji")
  end),

  -- Open rofi power menu
  awful.key({}, "#191", function()
    awful.util.spawn("rofi -show p -modi p:rofi-power-menu")
  end),

  -- Open rofi widgets menu
  awful.key({}, "#192", function()
    os.execute("~/bin/widgets")
  end),

  -- Opens rofi bookmarks menu
  awful.key({}, "#201", function()
    os.execute("~/bin/bookmarks")
  end),

  -- Opens rofi search
  awful.key({}, "#198", function()
    os.execute("~/bin/web-search")
  end)
)

-- ================ SOUND ================
shortcuts.globalkeys = gears.table.join(
  shortcuts.globalkeys,
  -- Volume down
  awful.key({}, "#122", function()
    volume_widget:dec(5)
  end),
  -- Volume up
  awful.key({}, "#123", function()
    volume_widget:inc(5)
  end),
  -- Toggle mute/unmute
  awful.key({}, "#121", function()
    volume_widget:toggle()
  end)
)

-- ================ RANDOM BACKGROUND ================
shortcuts.globalkeys = gears.table.join(
  shortcuts.globalkeys,
  awful.key({ config.modkey }, "b", function()
    os.execute('feh --bg-fill "$(find ~/Nextcloud/Sync/Backgrounds -type f | shuf -n 1)"')
  end)
)

root.keys(shortcuts.globalkeys)

return shortcuts
