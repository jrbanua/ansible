#!/bin/bash

cd /etc/dconf/db/local.d/locks
sudo rm background
dconf write /org/gnome/desktop/background/picture-uri "'file:///usr/share/backgrounds/Wonders_Wallpaper.png'"
