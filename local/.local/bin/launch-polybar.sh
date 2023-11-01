#!/usr/bin/env sh

# Terminate already running bar instances
pkill polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

if command -v darkman; then
  BAR=$(darkman get)
else
  BAR=dark
fi

# Launch bars on multiple monitors if available
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload "${BAR}" &
  done
else
  polybar --reload "${BAR}" &
fi

echo "Bars launched..."
