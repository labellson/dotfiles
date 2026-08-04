#!/usr/bin/env sh
BACKGROUND_DST="${HOME}/.background-image"
BACKGROUND_SRC="${HOME}/.dotfiles/wallpaper/solarized-${1}.jpg"

ln -sf ${BACKGROUND_SRC} ${BACKGROUND_DST}
systemctl --user restart swaybg
