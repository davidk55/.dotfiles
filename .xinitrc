#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

#if [ -d /etc/X11/xinit/xinitrc.d ] ; then
# for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
#  [ -x "$f" ] && . "$f"
# done
# unset f
#fi

# Add Compose Key
setxkbmap -option compose:ralt &

# Display resolution
xrandr --output eDP-1 --primary --mode 1920x1080 --rate 60 &

# Load background
exec feh --bg-fill ~/.local/share/backgrounds/2.jpg &

# Load compositor
picom --experimental-backends &

# Load dunst
dunst &

# Load kmonad
kmonad /home/david/.config/kmonad/keyboard.kdb &

# start the gnome-keyring-daemon
eval $(gnome-keyring-daemon --start) &
export SSH_AUTH_SOCK &
dbus-update-activation-environment --systemd DISPLAY & 

# Execute awesomewm
exec awesome
