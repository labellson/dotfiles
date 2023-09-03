#!/usr/bin/env sh
kitty +kitten themes --reload-in=all --dump-theme \
    "Solarized Dark" > ~/.config/kitty/theme.conf \
    && pkill --signal SIGUSR1 kitty
