#!/bin/bash
TMPBG=/tmp/screen.png
LOCK=/home/labellson/Pictures/icons/Lock-icon.png
RES=$(xrandr | grep '*' | sed -E "s/[^0-9]*([0-9]+)x([0-9]+).*/\1*\2/" | head -n1)

ffmpeg -f x11grab -video_size $RES -y -i $DISPLAY -i $LOCK -filter_complex "boxblur=5:1,overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2" -vframes 1 $TMPBG -loglevel quiet
convert $TMPBG -scale 10% -scale 1000% $TMPBG

i3lock --image $TMPBG --tiling --show-failed-attempts
rm $TMPBG
