#!/usr/bin/env sh

# parse cli arguments
ONE_BAR=false
while getopts "::o" opt; do
  case "${opt}" in
    o) ONE_BAR=true;;
  esac
done

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
# if [ "${ONE_BAR}" = true && type "xrandr" ]; then
if type "xrandr"; then
  if [ "${ONE_BAR}" = true ]; then
    polybar --reload "${BAR}" &
  else
    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
      MONITOR=$m polybar --reload "${BAR}" &
    done
  fi
fi

echo "Bars launched..."
