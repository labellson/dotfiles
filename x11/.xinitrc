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

###########
# Mi conf #
###########

# Set desktop session for icon themes on QT applications
export DESKTOP_SESSION=i3


# Set wallpaper
sh ~/.fehbg &
albert &
source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

# Arrancar polkit agent
/usr/lib/xfce-polkit/xfce-polkit &

# No funciona bien, freeze X11
#thunar --daemon 

exec i3

xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
