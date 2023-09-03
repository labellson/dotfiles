#!/usr/bin/env sh
kitty +kitten themes --reload-in=all --dump-theme \
    "Solarized Light" > ~/.config/kitty/theme.conf \
    && pkill --signal SIGUSR1 kitty
