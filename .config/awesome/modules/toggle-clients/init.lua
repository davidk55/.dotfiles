-- **********************************************************************************
--                                                                  __ _
--   __ ___      _____  ___  ___  _ __ ___   ___    ___ ___  _ __  / _(_) __ _
--  / _` \ \ /\ / / _ \/ __|/ _ \| '_ ` _ \ / _ \  / __/ _ \| '_ \| |_| |/ _` |
-- | (_| |\ V  V /  __/\__ \ (_) | | | | | |  __/ | (_| (_) | | | |  _| | (_| |
--  \__,_| \_/\_/ \___||___/\___/|_| |_| |_|\___|  \___\___/|_| |_|_| |_|\__, |
--                                                                       |___/
-- ********************************* @author davidk55 *******************************

local awful = require("awful")
local has_any_equal_client_info = require("modules.utils").has_any_equal_client_info

local M = {}

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
          c:swap(awful.client.getmaster())

          if c.floating then
            awful.placement.centered(c)
          end
        else
          if not in_active_tag(c) then
            move_to_focussed_tag(c)
            client.focus = c
          else
            c.hidden = true
            found.hidden = true
            found.active = false
          end
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
      c:swap(awful.client.getmaster())
      break
    end
  end
end

return M
