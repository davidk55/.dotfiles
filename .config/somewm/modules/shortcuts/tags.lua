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
local focus_master_if_needed = require("modules.toggle-clients").focus_master_if_needed

for i = 1, 5 do
  awful.keyboard.append_global_keybindings({
    -- View specific tag
    awful.key({ config.modkey }, "#" .. i + 9, function()
      for s in screen do
        local tag = s.tags[i]
        if tag then
          tag:view_only()
          focus_master_if_needed()
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
          focus_master_if_needed()
        end
      end
    end, { description = "move focused client to tag #" .. i, group = "awesome: tags" }),
  })
end

awful.keyboard.append_global_keybindings({
  awful.key({
    modifiers = { config.modkey },
    key = "Escape",
    on_press = awful.tag.history.restore,
    description = "go back to last tag",
    group = "tag",
  }),
})
