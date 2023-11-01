#!/usr/bin/env sh
# changing the custom gtk css theme. The files are automatically downloaded with
# nix and home-manager. Here we just make the symbolic links to the
# correspondent targets
#
# NOTE: the real .css are inside of ~/.config/gtk-4.0 folder
gtk_4="${HOME}/.config/gtk-4.0"
rm -f "${gtk_4}/gtk.css" && ln -s "${gtk_4}/gtk-dark.css" "${gtk_4}/gtk.css"

gtk_3="${HOME}/.config/gtk-3.0"
rm -f "${gtk_3}/gtk.css" && ln -s "${gtk_4}/gtk-dark.css" "${gtk_3}/gtk.css"


# by using xdg-desktop-portal you can unify how some applications choose the
# colorschemes.
#
# From the archwiki: the chromium browser uses this to set light or dark
# appearance https://wiki.archlinux.org/title/Chromium#Dark_mode
#
# It is done by changing the org.freedesktop.appearance colorscheme as it is
# documented in flatpak
# https://flatpak.github.io/xdg-desktop-portal/#gdbus-org.freedesktop.portal.Settings
dconf write /org/gnome/desktop/interface/color-scheme \'prefer-dark\'
