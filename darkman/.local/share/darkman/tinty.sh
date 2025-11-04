#!/usr/bin/env sh
## tinty is almost all I need to apply colorschemes
## https://github.com/tinted-theming/tinty
tinty apply "base16-selenized-${1}"

# needed to tell active kitty windows to reload the theme
pkill --signal SIGUSR1 kitty
