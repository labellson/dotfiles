#!/data/data/com.termux/files/usr/bin/sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch bars on multiple monitors if available
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload termux &
  done
else
  polybar --reload termux &
fi

echo "Bars launched..."
