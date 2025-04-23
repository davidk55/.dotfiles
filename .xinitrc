#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

# check if the file exists
if [ -f "$sysresources" ]; then

	xrdb -merge "$sysresources"

fi

if [ -f "$sysmodmap" ]; then
	xmodmap "$sysmodmap"
fi

if [ -f "$userresources" ]; then

	xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
	xmodmap "$usermodmap"
fi

# start the ssh agent
eval "$(ssh-agent)"

# Hide Clients
(
	sleep 6
	/home/david/bin/awesome-startup
) &

# Add Compose Key
setxkbmap -option compose:ralt &

# Load fcitx5
fcitx5 -d &

# Display resolution
xrandr --output eDP-1 --primary --mode 1920x1080 --rate 60 &

# Load background
exec feh --bg-fill "$(find ~/Nextcloud/Main/Further-Dotfiles/Backgrounds -type f | shuf -n 1)" &

# Load dunst
dunst &

# Execute awesomewm
exec awesome
