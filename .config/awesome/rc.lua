-- **********************************************************************************
--                                                                  __ _
--   __ ___      _____  ___  ___  _ __ ___   ___    ___ ___  _ __  / _(_) __ _
--  / _` \ \ /\ / / _ \/ __|/ _ \| '_ ` _ \ / _ \  / __/ _ \| '_ \| |_| |/ _` |
-- | (_| |\ V  V /  __/\__ \ (_) | | | | | |  __/ | (_| (_) | | | |  _| | (_| |
--  \__,_| \_/\_/ \___||___/\___/|_| |_| |_|\___|  \___\___/|_| |_|_| |_|\__, |
--                                                                       |___/
-- ********************************* @author davidk55 *******************************

pcall(require, "luarocks.loader")

-- ================ THEME ================
require("theme")

-- ================ CONFIG ================
require("config")

-- ================ LAYOUT ================
require("layout")

-- ================ STATUS-BAR ================
require("status-bar")

-- ================ SHORTCUTS ================
require("shortcuts")

-- ================ RULES ================
require("rules")

-- ================ SIGNALS ================
require("signals")

-- ================ AUTORUN ================
require("autorun")

-- ================ HOTKEYS-POPUP ================
require("hotkeys-popup-custom")

-- ================ ERROR-HANDLING ================
require("error-handling")

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
