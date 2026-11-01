-- **********************************************************************************
--                                               __ _
--   ___  ___  _ __ ___   ___    ___ ___  _ __  / _(_) __ _
-- / __|/ _ \| '_ ` _ \ / _ \  / __/ _ \| '_ \| |_| |/ _` |
-- \__ \ (_) | | | | | |  __/ | (_| (_) | | | |  _| | (_| |
-- |___/\___/|_| |_| |_|\___|  \___\___/|_| |_|_| |_|\__, |
--                                                   |___/
-- ********************************* @author davidk55 *******************************

local awful = require("awful")
local has_any_equal_client_info = require("modules.utils").has_any_equal_client_info

local M = {}

M.focus_master_if_needed = function()
  local s = awful.screen.focused()
  local t = s.selected_tag
  local c = client.focus

  if not s or not t then
    return
  end

  local function client_on_given_tag(client_to_check, tag_to_check)
    if not client_to_check or not tag_to_check then
      return false
    end

    for _, current_tag in ipairs(client_to_check:tags()) do
      if current_tag == tag_to_check then
        return true
      end
    end

    return false
  end

  local function is_on_screen_and_tag(client_to_check, tag_to_check)
    return client_to_check.screen == s and client_on_given_tag(client_to_check, tag_to_check)
  end

  local function is_hidden_or_minimized(client_to_check)
    return client_to_check.hidden == true or client_to_check.minimized == true
  end

  -- Keep the current focus if it belongs to this screen
  -- and is visible on one of its selected tags.
  if c and is_on_screen_and_tag(c, t) and not is_hidden_or_minimized(c) then
    return
  end

  local p = awful.layout.parameters(t)

  if p.clients == nil then
    return
  end

  for _, current_client in ipairs(p.clients) do
    if not is_hidden_or_minimized(current_client) and is_on_screen_and_tag(current_client, t) then
      current_client:activate({
        context = "focus_client",
        switch_to_tag = true,
      })
      break
    end
  end
end

local function in_active_tag(c)
  local tags = awful.screen.focused().selected_tags
  local found = false
  for _, t in ipairs(tags) do
    for _, tc in ipairs(t:clients()) do
      if tc == c then
        found = true
      end
    end
  end
  return found
end

local function move_to_focussed_tag(c)
  local first_focused_tag = awful.screen.focused().selected_tags[1]
  c:move_to_tag(first_focused_tag)
end

M.toggle_client = function(client_infos)
  local found
  for _, c in ipairs(client.get()) do
    if has_any_equal_client_info(c, client_infos) then
      (function()
        if c.minimized == true then
          c.minimized = false
          return
        end
        if found then
          if found.hidden == c.hidden then
            if found.hidden == false and found.active == in_active_tag(c) then
              move_to_focussed_tag(c)
            end
            return
          end
        end
        found = { hidden = false, active = true }
        if c.hidden then
          c.hidden = false

          if not in_active_tag(c) then
            move_to_focussed_tag(c)
          end

          client.focus = c
          c:swap(client.get(c.screen)[1])

          if c.floating then
            awful.placement.centered(c)
            c:raise()
          end
        else
          if not in_active_tag(c) then
            move_to_focussed_tag(c)
            client.focus = c

            if c.floating then
              awful.placement.centered(c)
              c:raise()
            end
          else
            awful.client.focus.history.delete(c)
            c.hidden = true

            found.hidden = true
            found.active = false
            awful.client.focus.history.delete(found)
            M.focus_master_if_needed()
          end
        end

        if (c.maximized and not c.hidden) and not DISTRACTION_FREE then
          c.screen.mywibox.visible = false
        elseif c.maximized and not DISTRACTION_FREE then
          c.screen.mywibox.visible = true
        end
      end)()
    end
  end
end

M.show_client = function(client_infos)
  for _, c in ipairs(client.get()) do
    if has_any_equal_client_info(c, client_infos) then
      if c.hidden == true then
        c.hidden = false
      end

      if not in_active_tag(c) then
        move_to_focussed_tag(c)
      end
      client.focus = c
      c:swap(client.get(c.screen)[1])
      break
    end
  end
end

return M
