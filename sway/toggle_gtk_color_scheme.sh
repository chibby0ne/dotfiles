#!/usr/bin/env bash

set -x
current=$(gsettings get org.gnome.desktop.interface color-scheme)
current="${current//\'/}"
if [[ ${current} == "prefer-light" || ${current} == "default" ]]; then
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
else
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
fi
