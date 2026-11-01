-- **********************************************************************************
--                                               __ _
--   ___  ___  _ __ ___   ___    ___ ___  _ __  / _(_) __ _
-- / __|/ _ \| '_ ` _ \ / _ \  / __/ _ \| '_ \| |_| |/ _` |
-- \__ \ (_) | | | | | |  __/ | (_| (_) | | | |  _| | (_| |
-- |___/\___/|_| |_| |_|\___|  \___\___/|_| |_|_| |_|\__, |
--                                                   |___/
-- ********************************* @author davidk55 *******************************

local awful = require("awful")
local config = require("modules.config")
local mouse_on_focussed_client = require("modules.interaction").mouse_on_focussed_client

client.connect_signal("request::default_keybindings", function()
  awful.keyboard.append_client_keybindings({
    -- Make client fullscreen
    awful.key({ config.modkey }, "f", function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
      mouse_on_focussed_client()
    end, { description = "toggle fullscreen", group = "awesome: clients" }),

    -- Kill current client
    awful.key({ config.modkey, "Shift" }, "c", function(c)
      c:kill()
    end, { description = "close", group = "awesome: clients" }),

    -- Toggle client floating
    awful.key({ config.modkey, "Control" }, "space", function(c)
      c.floating = not c.floating
      c.ontop = false
    end, { description = "toggle floating", group = "awesome: clients" }),

    -- Make focused client master
    awful.key({ config.modkey }, ".", function(c)
      awful.client.focus.history.disable_tracking()

      local clients = client.get(c.screen)
      local focussed_client_is_master = clients[1] == c

      if focussed_client_is_master then
        local current_screen = awful.screen.focused()
        local last_focused_client = awful.client.focus.history.get(current_screen, 1)
        client.focus = last_focused_client
        last_focused_client:swap(c)
      else
        local current_master = clients[1]
        c:to_primary_section()

        awful.client.focus.history.delete(current_master)
        table.insert(awful.client.focus.history.list, 2, current_master)
      end

      awful.client.focus.history.enable_tracking()
    end, { description = "move to master", group = "awesome: clients" }),

    -- Move focused client to next screen
    awful.key({ config.modkey, "Shift" }, ",", function(c)
      local index = c.first_tag.index
      local tag = c.screen.tags[index]
      c:move_to_tag(tag)
      c:move_to_screen()
    end, { description = "move to screen", group = "awesome: clients" }),

    -- Minimize focused client
    awful.key({ config.modkey }, "n", function(c)
      c.minimized = true
    end, { description = "minimize", group = "awesome: clients" }),

    -- Toggle maximize the focused client
    awful.key({ config.modkey }, "m", function(c)
      c.maximized = not c.maximized
      if c.maximized == true then
        local focussed_screen = awful.screen.focused()
        if not DISTRACTION_FREE then
          return
        end
        focussed_screen.mywibox.visible = false
      else
        if not DISTRACTION_FREE then
          return
        end
        for s in screen do
          s.mywibox.visible = true
        end
      end
      c:raise()
      mouse_on_focussed_client()
    end, { description = "(un)maximize", group = "awesome: clients" }),

    -- Toggle maximize the focused client vertically
    awful.key({ config.modkey, "Control" }, "m", function(c)
      c.maximized_vertical = not c.maximized_vertical
      c:raise()
      mouse_on_focussed_client()
    end, { description = "(un)maximize vertically", group = "awesome: clients" }),

    -- Toggle maximize the focused client horizontally
    awful.key({ config.modkey, "Shift" }, "m", function(c)
      c.maximized_horizontal = not c.maximized_horizontal
      c:raise()
      mouse_on_focussed_client()
    end, { description = "(un)maximize horizontally", group = "awesome: clients" }),

    -- Focus the next client (by index)
    awful.key({ config.modkey }, "j", function()
      awful.client.focus.byidx(1)
      mouse_on_focussed_client()
    end, { description = "focus next by index", group = "awesome: clients" }),

    -- Focus the previous client (by index)
    awful.key({ config.modkey }, "k", function()
      awful.client.focus.byidx(-1)
      mouse_on_focussed_client()
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
      mouse_on_focussed_client()
    end, { description = "go back", group = "awesome: clients" }),

    -- Restore last minimized client
    awful.key({ config.modkey, "Control" }, "n", function()
      local c = awful.client.restore()
      -- Focus restored client
      if c then
        c:emit_signal("request::activate", "key.unminimize", { raise = true })
      end
      mouse_on_focussed_client()
    end, { description = "restore minimized", group = "awesome: clients" }),

    -- Focus the last client (by focus)
    awful.key({ config.modkey, "Shift" }, "f", function()
      if client.focus then
        local c = client.focus
        c.floating = true
        c.ontop = true
      end
    end, { description = "set floating and ontop", group = "awesome: clients" }),
  })
end)
