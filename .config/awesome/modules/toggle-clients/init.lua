-- **********************************************************************************
--                                                                  __ _
--   __ ___      _____  ___  ___  _ __ ___   ___    ___ ___  _ __  / _(_) __ _
--  / _` \ \ /\ / / _ \/ __|/ _ \| '_ ` _ \ / _ \  / __/ _ \| '_ \| |_| |/ _` |
-- | (_| |\ V  V /  __/\__ \ (_) | | | | | |  __/ | (_| (_) | | | |  _| | (_| |
--  \__,_| \_/\_/ \___||___/\___/|_| |_| |_|\___|  \___\___/|_| |_|_| |_|\__, |
--                                                                       |___/
-- ********************************* @author davidk55 *******************************

local awful = require("awful")

local function client_is_in_active_tag(c)
    local tags = awful.screen.focused().selected_tags
    local found = false
    for _, t in ipairs(tags) do
        for _, tc in ipairs(t:clients()) do
            if tc == c then found = true end
        end
    end
    return found
end

local function is_the_searched_client(c, client_infos)
    if client_infos.name then
        return c.name == client_infos.name
    end
    if client_infos.class then
        return c.class == client_infos.class
    end
    if client_infos.instance then
        return c.instance == client_infos.instance
    end
    return false
end

local function move_to_first_focused_tag(c)
    local first_focused_tag = awful.screen.focused().selected_tags[1]
    c:move_to_tag(first_focused_tag)
end

local function toggle_client(client_infos)
    local found
    for _, c in ipairs(client.get()) do
        if is_the_searched_client(c, client_infos) then
            if found then
                if found.hidden == c.hidden then
                    if found.hidden == false and found.active == client_is_in_active_tag(c) then
                        move_to_first_focused_tag(c)
                    end
                    goto skip_to_next
                end
            end
            found = { hidden = false, active = true }
            if c.hidden then
                c.hidden = false
                if not client_is_in_active_tag(c) then
                    move_to_first_focused_tag(c)
                end
                client.focus = c
            else
                if not client_is_in_active_tag(c) then
                    move_to_first_focused_tag(c)
                    client.focus = c
                else
                    c.hidden = true
                    found.hidden = true
                    found.active = false
                end
            end
            ::skip_to_next::
        end
    end
end

return toggle_client
