#!/bin/sh

sysresources=/etc/X11/xinit/.Xresources
userresources=$HOME/.Xresources

# merge in system defaults and user resources

[[ -f "$sysresources" ]] && xrdb -merge -I$HOME "$sysresources"
[[ -f "$userresources" ]] && xrdb -merge -I$HOME "$userresources"

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi


# Set desktop session for icon themes on QT applications
# this env var became already legacy
export DESKTOP_SESSION=i3

# if I ever use a desktop environment this may make it choose
# the window manager I want
export WINDOW_MANAER=i3

# Set terminal so i3 is able to launch the correct one
export TERMINAL=kitty

#TODO: is there a better way to do this??
# configure the monitor
if [ "$(xrandr --listactivemonitors | grep DP1)" ]; then
    # setup for home (with my monitor)
    config-monitor.sh -m home -r
else
    # just use the laptop screen
    config-monitor.sh -m laptop
fi

# Set wallpaper
# sh ~/.fehbg &

exec i3
