#!/bin/bash
TOUCHPAD=$(cat $HOME/.config/i3/.touchpad-active-id)

if [ "$TOUCHPAD" == "0" ]
then
    TOUCHPAD="1"
else
    TOUCHPAD="0"
fi

echo $TOUCHPAD > $HOME/.config/i3/.touchpad-active-id

xinput set-prop DLL07BE:01\ 06CB:7A13\ Touchpad "libinput Disable While Typing Enabled" $TOUCHPAD
