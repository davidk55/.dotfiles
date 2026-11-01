-- **********************************************************************************
--                                               __ _
--   ___  ___  _ __ ___   ___    ___ ___  _ __  / _(_) __ _
-- / __|/ _ \| '_ ` _ \ / _ \  / __/ _ \| '_ \| |_| |/ _` |
-- \__ \ (_) | | | | | |  __/ | (_| (_) | | | |  _| | (_| |
-- |___/\___/|_| |_| |_|\___|  \___\___/|_| |_|_| |_|\__, |
--                                                   |___/
-- ********************************* @author davidk55 *******************************

local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local config = require("modules.config")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local mouse_on_focussed_client = require("modules.interaction").mouse_on_focussed_client

local toggleable_applications = {
  class = {
    "firefox",
    "LibreWolf",
    "floorp",
    "md.obsidian.Obsidian",
    "KeePassXC",
    "dolphin",
    "Mailspring",
    "Spotify",
    "anki",
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
awful.keyboard.append_global_keybindings({
  -- Hotkey popup
  awful.key({ config.modkey }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome: general" }),

  -- Focus the next screen (by index)
  awful.key({ config.modkey }, ",", function()
    local next_screen_index = (mouse.screen.index % screen.count()) + 1
    local next_screen = screen[next_screen_index]

    if not (#next_screen.clients == 0) then
      if client.focus then
        awful.screen.focus_relative(1)
      else
        awful.screen.focus(next_screen)
      end
      mouse_on_focussed_client()
    else
      awful.screen.focus(next_screen)
    end
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
  awful.key(
    { config.modkey, "Shift" },
    "q",
    awesome.quit,
    { description = "quit awesome", group = "awesome: general" }
  ),

  -- Increase master width
  awful.key({ config.modkey }, "l", function()
    awful.tag.incmwfact(0.05)
  end, { description = "increase master width factor", group = "awesome: layout" }),

  -- Decrease master width
  awful.key({ config.modkey }, "h", function()
    awful.tag.incmwfact(-0.05)
  end, { description = "decrease master width factor", group = "awesome: layout" }),

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
    if not DISTRACTION_FREE then
      DISTRACTION_FREE = true

      beautiful.useless_gap = dpi(12)
      for _, c in ipairs(client.get()) do
        c.border_width = 3
      end
      for s in screen do
        s.mywibox.visible = true
      end
    else
      DISTRACTION_FREE = false

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
    -- TODO: implement
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
})
