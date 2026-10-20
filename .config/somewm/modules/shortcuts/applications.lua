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
local toggle_client = require("modules.toggle-clients").toggle_client
local volume_widget = require("modules.awesome-wm-widgets.volume-widget.volume")

-- ================ APPLICATIONS ================
awful.keyboard.append_global_keybindings({
  -- Toggle firefox client
  awful.key({ config.modkey }, "i", function()
    toggle_client({ class = "LibreWolf" })
    toggle_client({ class = "firefox" })
    toggle_client({ class = "floorp" })
  end),

  -- Toggle obsidian client
  awful.key({ config.modkey }, "o", function()
    toggle_client({ class = "md.obsidian.Obsidian" })
    local naughty = require("naughty")

    naughty.notification({
      title = "Debug",
      message = tostring(client.focus and client.focus.class or "no focus"),
    })
  end),

  -- Toggle keepass client
  awful.key({ config.modkey }, "p", function()
    toggle_client({ class = "KeePassXC" })
    toggle_client({ class = "org.keepassxc.KeePassXC" })
  end),

  -- Toggle dev client
  awful.key({ config.modkey }, ";", function()
    toggle_client({ name = "dev" })
  end),

  -- Toggle pdf viewer
  awful.key({ config.modkey }, "'", function()
    toggle_client({ class = "dolphin" })
    toggle_client({ class = "org.kde.dolphin" })
  end),

  -- Toggle e-mail client
  awful.key({ config.modkey }, "u", function()
    toggle_client({ class = "org.mozilla.Thunderbird" })
  end),

  -- Toggle spotify client
  awful.key({ config.modkey }, "[", function()
    toggle_client({ class = "Spotify" })
  end),

  -- Toggle discord client
  awful.key({ config.modkey }, "]", function()
    toggle_client({ instance = "discord" })
    toggle_client({ class = "discord" })
  end),

  -- Toggle intellij client
  awful.key({ config.modkey }, "y", function()
    toggle_client({ instance = "jetbrains-idea-ce" })
  end),

  -- Toggle newsboat
  awful.key({ config.modkey }, "r", function()
    awful.spawn.easy_async(config.terminal .. " -e newsboat -u ~/Nextcloud/Main/Further-Dotfiles/config/newsboat/urls")
  end),

  -- Toggle anki
  awful.key({ config.modkey }, "a", function()
    toggle_client({ class = "anki" })
  end),

  -- Toggle whatsapp
  awful.key({ config.modkey }, "d", function()
    toggle_client({ class = "Whatsapp-for-linux" })
  end),

  -- Open calculator
  awful.key({ config.modkey }, "c", function()
    toggle_client({ class = "qalculate-gtk" })
    toggle_client({ class = "Qalculate-gtk" })
  end),

  -- Toggle pomodoro
  awful.key({ config.modkey }, "t", function()
    toggle_client({ class = "io.github.focustimerhq.FocusTimer" })
  end),
})

-- ================ ROFI/FZF ================
awful.keyboard.append_global_keybindings({
  -- Open rofi drun
  awful.key({}, "#202", function()
    awful.spawn.with_shell("rofi -show drun -show-icons")
  end),

  -- Open rofi calculator
  awful.key({}, "#148", function()
    awful.spawn.with_shell(
      "rofi -show calc -modi calc -no-show-match -no-sort -no-persist-history -calc-command 'echo -n '{result}' | wl-copy'"
    )
  end),

  -- Open rofi emoji selector
  awful.key({}, "#193", function()
    awful.spawn.with_shell("rofi -show emoji -modi emoji")
  end),

  -- Open rofi power menu
  awful.key({}, "#191", function()
    awful.spawn.with_shell("rofi -show p -modi p:rofi-power-menu")
  end),

  -- Open rofi widgets menu
  awful.key({}, "#192", function()
    awful.spawn("/home/david/bin/rofi-widgets")
  end),

  -- Opens rofi bookmarks menu
  awful.key({}, "#201", function()
    awful.spawn("/home/david/bin/rofi-bookmarks")
  end),

  -- Opens rofi firefox bookmarks menu
  -- awful.key({}, "#197", function()
  --   awful.spawn.with_shell(
  --     "rofi -show firefox_bookmarks -modi \"firefox_bookmarks:~/Nextcloud/Main/Further-Dotfiles/scripts/rofi-bookmarks-firefox\" -theme-str 'window {width: 70%;height: 60%;}'"
  --   )
  -- end),

  -- Opens clipboard history
  awful.key({}, "#197", function()
    awful.spawn("copyq show")
  end),

  -- Opens rofi search
  awful.key({}, "#198", function()
    awful.spawn("/home/david/bin/rofi-web-search")
  end),

  -- Opens rofi setup launcher
  awful.key({}, "#200", function()
    awful.spawn("/home/david/Nextcloud/Main/Further-Dotfiles/scripts/setup-launcher/rofi-setup-launcher")
  end),

  -- Opens rofi appimages
  awful.key({}, "#196", function()
    awful.spawn("/home/david/bin/rofi-appimages")
  end),
})

-- ================ SOUND ================
local function togglePause()
  for _, c in ipairs(client.get()) do
    if c.class == "Spotify" then
      awful.spawn.easy_async("sp play")
      return
    end
  end
  -- awful.spawn.easy_async('xdotool key --window "$(xdotool search --class firefox | tail -1)" XF86AudioPlay')
end
awful.keyboard.append_global_keybindings({
  -- Volume down
  awful.key({}, "#122", function()
    volume_widget:dec(5)
  end),
  -- Volume up
  awful.key({}, "#123", function()
    volume_widget:inc(5)
  end),
  -- Toggle mute/unmute
  awful.key({}, "#121", function()
    volume_widget:toggle()
  end),
  awful.key({}, "#208", function()
    togglePause()
  end),
  awful.key({}, "#209", function()
    togglePause()
  end),
  awful.key({}, "#171", function()
    os.execute("playerctl next")
  end),
  awful.key({}, "#173", function()
    os.execute("playerctl previous")
  end),
  awful.key({}, "#172", function()
    os.execute("playerctl play-pause")
  end),
})

-- ================ RANDOM BACKGROUND ================
awful.keyboard.append_global_keybindings({
  awful.key({ config.modkey }, "b", function()
    awful.spawn.with_shell(
      'somewm-client wallpaper set "$(find ~/Nextcloud/Main/Further-Dotfiles/Backgrounds -type f | shuf -n 1)"'
    )
  end),
})
