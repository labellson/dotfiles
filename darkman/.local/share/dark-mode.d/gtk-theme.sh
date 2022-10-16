#!/usr/bin/env sh
# my theme does not change with the following command...
# gsettings set org.gnome.desktop.interface gtk-theme Arc-Dark
sed -i -e 's/\(gtk-theme-name=\).*$/\1Arc-Dark/g' ~/.config/gtk-3.0/settings.ini
sed -i -e 's/\(gtk-icon-theme-name=\).*$/\1Papirus-Dark/g' ~/.config/gtk-3.0/settings.ini
