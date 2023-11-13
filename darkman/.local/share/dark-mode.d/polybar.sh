#!/usr/bin/env sh
# HACK: I need to add the $PATH because I coudn't make it work
PATH="${HOME}/.local/bin:${PATH}"
[[ $(command -v launch-polybar.sh) ]] && launch-polybar.sh
