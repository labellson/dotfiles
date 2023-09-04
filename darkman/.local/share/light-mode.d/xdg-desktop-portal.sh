#!/usr/bin/env sh
# by using xdg-desktop-portal you can unify how some applications choose the
# colorschemes.
#
# From the archwiki: the chromium browser uses this to set light or dark
# appearance https://wiki.archlinux.org/title/Chromium#Dark_mode
#
# It is done by changing the org.freedesktop.appearance colorscheme as it is
# documented in flatpak
# https://flatpak.github.io/xdg-desktop-portal/#gdbus-org.freedesktop.portal.Settings
dconf write /org/gnome/desktop/interface/color-scheme \'prefer-light\'
