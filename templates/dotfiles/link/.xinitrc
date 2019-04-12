#!/bin/sh

xrandr --output DisplayPort-1-2 --auto
xrandr --output DP-2 --auto
xrandr --output DVI-1-0 --auto
xrandr --output DVI-1-0 --right-of DP-2
xrandr --output DisplayPort-1-2 --left-of DP-2

xset +fp /home/chad/.local/share/fonts/
xset fp rehash

shxkd &
exec bspwm