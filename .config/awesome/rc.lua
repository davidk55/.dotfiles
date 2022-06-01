-- **********************************************************************************
--                                                                  __ _
--   __ ___      _____  ___  ___  _ __ ___   ___    ___ ___  _ __  / _(_) __ _
--  / _` \ \ /\ / / _ \/ __|/ _ \| '_ ` _ \ / _ \  / __/ _ \| '_ \| |_| |/ _` |
-- | (_| |\ V  V /  __/\__ \ (_) | | | | | |  __/ | (_| (_) | | | |  _| | (_| |
--  \__,_| \_/\_/ \___||___/\___/|_| |_| |_|\___|  \___\___/|_| |_|_| |_|\__, |
--                                                                       |___/
-- ********************************* @author davidk55 *******************************

local beautiful = require("beautiful")

pcall(require, "luarocks.loader")

-- ================ THEME ================
local theme = require("modules.theme")
beautiful.init(theme)

-- ================ CONFIG ================
require("modules.config")

-- ================ LAYOUT ================
require("modules.layout")

-- ================ STATUS-BAR ================
require("modules.status-bar")

-- ================ SHORTCUTS ================
require("modules.shortcuts")

-- ================ RULES ================
require("modules.rules")

-- ================ SIGNALS ================
require("modules.signals")

-- ================ AUTORUN ================
require("modules.autorun")

-- ================ HOTKEYS-POPUP ================
require("modules.hotkeys-popup-custom")

-- ================ ERROR-HANDLING ================
require("modules.error-handling")

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
