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

-- Track focus order. Weak keys allow closed clients to be collected.
local focus_order = setmetatable({}, { __mode = "k" })
local focus_counter = 0

client.connect_signal("focus", function(c)
  focus_counter = focus_counter + 1
  focus_order[c] = focus_counter
end)

local function in_active_tag(c, s)
  if not c.valid or c.screen ~= s then
    return false
  end

  for _, tag in ipairs(s.selected_tags) do
    for _, tc in ipairs(tag:clients()) do
      if tc == c then
        return true
      end
    end
  end

  return false
end

local function get_matching_clients(client_infos)
  local matches = {}

  for _, c in ipairs(client.get()) do
    if c.valid and has_any_equal_client_info(c, client_infos) then
      matches[#matches + 1] = c
    end
  end

  -- Most recently focused first. Use client ID-independent focus
  -- ordering rather than relying on client.get() list order.
  table.sort(matches, function(a, b)
    return (focus_order[a] or 0) > (focus_order[b] or 0)
  end)

  return matches
end

local function get_last_focused(matches)
  -- matches are already sorted by focus history.
  return matches[1]
end

local function move_to_focused_tag(c, s, tag)
  if not c.valid or not tag then
    return
  end

  -- Capture s and tag before moving: moving a client can change
  -- the globally focused screen.
  if c.screen ~= s then
    c:move_to_screen(s)
  end

  if c.valid then
    c:move_to_tag(tag)
  end
end

local function show_client(c, s, tag)
  if not c or not c.valid then
    return
  end

  c.minimized = false
  c.hidden = false

  move_to_focused_tag(c, s, tag)

  if not c.valid then
    return
  end

  local master = awful.client.getmaster(s)

  if master and master ~= c then
    c:swap(master)
  end

  client.focus = c

  if c.floating then
    awful.placement.centered(c)
  end

  c:raise()
end

local function promote_client(c, s, tag)
  if not c or not c.valid then
    return
  end

  if c.hidden or c.minimized or c.screen ~= s or not in_active_tag(c, s) then
    show_client(c, s, tag)
    return
  end

  local master = awful.client.getmaster(s)

  if master and master ~= c then
    c:swap(master)
  end

  client.focus = c
  c:raise()
end

local function get_visible_matches(matches, s)
  local result = {}

  for _, c in ipairs(matches) do
    if c.valid and c.screen == s and not c.hidden and not c.minimized and in_active_tag(c, s) then
      result[#result + 1] = c
    end
  end

  return result
end

local function get_next_matching(matches, current)
  local current_index

  for i, c in ipairs(matches) do
    if c == current then
      current_index = i
      break
    end
  end

  if not current_index or #matches < 2 then
    return nil
  end

  for offset = 1, #matches - 1 do
    local i = ((current_index - 1 + offset) % #matches) + 1
    local c = matches[i]

    if c.valid then
      return c
    end
  end

  return nil
end

local function focus_fallback(s)
  for _, c in ipairs(client.get(s)) do
    if c.valid and not c.hidden and not c.minimized and c:isvisible() then
      client.focus = c
      return
    end
  end

  client.focus = nil
end

local function hide_client(c)
  if not c.valid then
    return
  end

  local s = c.screen

  awful.client.focus.history.delete(c)
  c.hidden = true

  if c.maximized and not DISTRACTION_FREE and s.mywibox then
    s.mywibox.visible = true
  end
end

local function hide_all_on_screen(matches, s)
  for _, c in ipairs(matches) do
    if c.valid and c.screen == s then
      hide_client(c)
    end
  end

  focus_fallback(s)
end

M.toggle_client = function(client_infos)
  local s = awful.screen.focused()
  local tag = s.selected_tags[1]

  if not tag then
    return
  end

  local matches = get_matching_clients(client_infos)

  if #matches == 0 then
    return
  end

  -- Single matching client.
  if #matches == 1 then
    local c = matches[1]

    if c.hidden or c.minimized or c.screen ~= s or not in_active_tag(c, s) then
      show_client(c, s, tag)
      return
    end

    if awful.client.getmaster(s) ~= c then
      promote_client(c, s, tag)
    else
      hide_client(c)
      focus_fallback(s)
    end

    return
  end

  local visible_matches = get_visible_matches(matches, s)

  -- No visible matching client on the focused tag:
  -- show the most recently focused match.
  if #visible_matches == 0 then
    show_client(get_last_focused(matches), s, tag)
    return
  end

  local master = awful.client.getmaster(s)
  local master_matches = false

  for _, c in ipairs(visible_matches) do
    if c == master then
      master_matches = true
      break
    end
  end

  -- A matching client is visible, but the master is not a match.
  if not master_matches then
    promote_client(visible_matches[1], s, tag)
    return
  end

  -- If every matching client is already on this screen,
  -- hide them instead of cycling.
  local all_on_screen = true

  for _, c in ipairs(matches) do
    if c.screen ~= s then
      all_on_screen = false
      break
    end
  end

  if all_on_screen then
    hide_all_on_screen(matches, s)
    return
  end

  -- Some matches are elsewhere: promote the next match.
  local next_client = get_next_matching(matches, master)

  if next_client then
    show_client(next_client, s, tag)
  else
    hide_all_on_screen(visible_matches, s)
  end
end

M.show_client = function(client_infos)
  local s = awful.screen.focused()
  local tag = s.selected_tags[1]

  if not tag then
    return
  end

  local matches = get_matching_clients(client_infos)
  local c = get_last_focused(matches)

  if c then
    show_client(c, s, tag)
  end
end

return M
