#!/usr/bin/env sh
# my theme does not change with the following command...
# gsettings set org.gnome.desktop.interface gtk-theme Arc-Lighter
sed -i -e 's/\(gtk-theme-name=\).*$/\1Arc-Lighter/g' ~/.config/gtk-3.0/settings.ini
sed -i -e 's/\(gtk-icon-theme-name=\).*$/\1Papirus-Light/g' ~/.config/gtk-3.0/settings.ini
