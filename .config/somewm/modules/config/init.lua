-- **********************************************************************************
--                                               __ _
--   ___  ___  _ __ ___   ___    ___ ___  _ __  / _(_) __ _
-- / __|/ _ \| '_ ` _ \ / _ \  / __/ _ \| '_ \| |_| |/ _` |
-- \__ \ (_) | | | | | |  __/ | (_| (_) | | | |  _| | (_| |
-- |___/\___/|_| |_| |_|\___|  \___\___/|_| |_|_| |_|\__, |
--                                                   |___/
-- ********************************* @author davidk55 *******************************

local menubar = require("menubar")
local awful = require("awful")

local config = {}

-- ================ VARIABLES ================
config.terminal = "kitty"
config.editor = os.getenv("EDITOR")
config.modkey = "Mod4"

-- ================ SET APPLICATION TERMINAL ================
menubar.utils.terminal = config.terminal

-- ================ INPUT DEVICE CONFIGURATION ================
awful.input.tap_to_click = 1
awful.input.natural_scrolling = 0
awful.input.accel_speed = 0
awful.input.accel_profile = "flat"
awful.input.xkb_layout = "us"
awful.input.xkb_options = "compose:ralt"
awful.input.keyboard_repeat_rate = 25
awful.input.keyboard_repeat_delay = 210

-- ================ SET LAYOUTS ================
awful.layout.append_default_layout(awful.layout.suit.spiral.dwindle)

return config
