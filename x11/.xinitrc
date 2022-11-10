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

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi


# Set desktop session for icon themes on QT applications
export DESKTOP_SESSION=i3

# Set terminal so i3 is able to launch the correct one
export TERMINAL=alacritty

source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

# configure the monitor
if [ "$(xrandr --listactivemonitors | grep DP1)" ]; then
    # setup for home (with my monitor)
    config-monitor.sh -m home -r
else
    # just use the laptop screen
    config-monitor.sh -m laptop
fi

# Set wallpaper
sh ~/.fehbg &

exec i3
