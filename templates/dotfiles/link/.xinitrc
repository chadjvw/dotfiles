#!/bin/bash

export SXHKD_SHELL=/bin/bash
export XDG_DATA_DIRS="$HOME/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/local/share:/usr/share"

xrandr --output DisplayPort-1-2 --auto
xrandr --output DP-2 --auto
xrandr --output DVI-1-0 --auto
xrandr --output DVI-1-0 --right-of DP-2
xrandr --output DisplayPort-1-2 --left-of DP-2

xset +fp /home/{{ username }}/.local/share/fonts/
xset fp rehash

shxkd &
exec bspwm