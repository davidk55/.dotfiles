-- **********************************************************************************
--                                                                  __ _
--   __ ___      _____  ___  ___  _ __ ___   ___    ___ ___  _ __  / _(_) __ _
--  / _` \ \ /\ / / _ \/ __|/ _ \| '_ ` _ \ / _ \  / __/ _ \| '_ \| |_| |/ _` |
-- | (_| |\ V  V /  __/\__ \ (_) | | | | | |  __/ | (_| (_) | | | |  _| | (_| |
--  \__,_| \_/\_/ \___||___/\___/|_| |_| |_|\___|  \___\___/|_| |_|_| |_|\__, |
--                                                                       |___/
-- ********************************* @author davidk55 *******************************

local awful = require("awful")
local beautiful = require("beautiful")
local has_any_equal_client_info = require("modules.utils").has_any_equal_client_info

local M = {}

M.mouse_on_focussed_client = function()
  local geometry = client.focus:geometry()
  local x = geometry.x + geometry.width / 2
  local y = geometry.y + geometry.height / 2
  mouse.coords({ x = x, y = y }, true)
end

M.switch_to_tag = function(tag_number)
  awful.screen.connect_for_each_screen(function(s)
    local tag = s.tags[tag_number]
    if tag then
      tag:view_only()
    end
  end)
end

M.switch_to_screen = function(screen_number)
  for s in screen do
    if s.index == screen_number then
      awful.screen.focus(s)
      break
    end
  end
end

M.apply_distraction_free = function()
  beautiful.useless_gap = 0
  for _, c in ipairs(client.get()) do
    c.border_width = 2
  end
  for s in screen do
    s.mywibox.visible = false
  end

  for s in screen do
    awful.layout.arrange(s)
  end
end

M.hide_clients = function(exceptions)
  for _, c in ipairs(client.get()) do
    local is_exception = false
    for _, client_info in ipairs(exceptions) do
      if has_any_equal_client_info(c, client_info) then
        is_exception = true
      end
    end

    if not is_exception then
      c.hidden = true
    end
  end
end

M.move_client_to_screen = function(client_info, screen_number)
  local client_to_move = nil

  for _, c in ipairs(client.get()) do
    if has_any_equal_client_info(c, client_info) then
      client_to_move = c
    end
  end

  if client_to_move == nil then
    return
  end

  for s in screen do
    if s.index == screen_number then
      client_to_move.screen = screen_number
      return
    end
  end
end

return M
