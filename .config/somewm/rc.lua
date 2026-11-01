-- **********************************************************************************
--                                               __ _
--   ___  ___  _ __ ___   ___    ___ ___  _ __  / _(_) __ _
-- / __|/ _ \| '_ ` _ \ / _ \  / __/ _ \| '_ \| |_| |/ _` |
-- \__ \ (_) | | | | | |  __/ | (_| (_) | | | |  _| | (_| |
-- |___/\___/|_| |_| |_|\___|  \___\___/|_| |_|_| |_|\__, |
--                                                   |___/
-- ********************************* @author davidk55 *******************************

-- disable naughty notifications (use dunst instead)
package.loaded["naughty.dbus"] = {}

local beautiful = require("beautiful")

pcall(require, "luarocks.loader")

-- ================ THEME ================
local theme = require("modules.theme")
beautiful.init(theme)

-- ================ CONFIG ================
require("modules.config")

-- ================ STATUS-BAR ================
require("modules.status-bar")

-- ================ SHORTCUTS ================
require("modules.shortcuts")

-- ================ RULES ================
require("modules.rules")

-- ================ AUTORUN ================
require("modules.autorun")

-- ================ HOTKEYS-POPUP ================
require("modules.hotkeys-popup-custom")

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
