#!/usr/bin/env sh
BACKGROUND_DST="${HOME}/.background-image"
BACKGROUND_SRC="${HOME}/.dotfiles/wallpaper/solarized-dark.jpg"

ln -sf ${BACKGROUND_SRC} ${BACKGROUND_DST}
feh --no-fehbg --bg-fill ${BACKGROUND_DST}
