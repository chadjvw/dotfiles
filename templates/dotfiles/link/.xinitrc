#!/bin/sh

# test for an existing bus daemon, just to be safe
if test -z "$DBUS_SESSION_BUS_ADDRESS" ; then
  # if not found, launch a new one
  eval `dbus-launch --sh-syntax --exit-with-session`
  echo "D-Bus per-session daemon address is: $DBUS_SESSION_BUS_ADDRESS"
fi

# set env vars
export SXHKD_SHELL=/bin/bash
export XDG_DATA_DIRS="$HOME/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/local/share:/usr/share"

# fix monitors
xrandr --output DisplayPort-1-2 --auto
xrandr --output DP-2 --auto
xrandr --output DVI-1-0 --auto
xrandr --output DVI-1-0 --right-of DP-2
xrandr --output DisplayPort-1-2 --left-of DP-2

# enable fonts
xset +fp /home/{{ username }}/.local/share/fonts/
xset fp rehash

# exec
shxkd &
exec dbus-launch bspwm