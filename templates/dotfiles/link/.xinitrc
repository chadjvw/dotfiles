#!/bin/sh

# test for an existing bus daemon, just to be safe
if test -z "$DBUS_SESSION_BUS_ADDRESS" ; then
  # if not found, launch a new one
  eval `dbus-launch --sh-syntax --exit-with-session`
  echo "D-Bus per-session daemon address is: $DBUS_SESSION_BUS_ADDRESS"
fi

# set env vars
export SXHKD_SHELL=/bin/bash
# export VDPAU_DRIVER=radeonsi
# export LIBVA_DRIVER_NAME=i965

# fix monitors
xrandr --dpi 100
xrandr --output {{ center_monitor }} --auto
xrandr --output {{ left_monitor }} --auto
xrandr --output {{ right_monitor }} --auto
xrandr --output {{ right_monitor }} --right-of {{ center_monitor }}
xrandr --output {{ left_monitor }} --left-of {{ center_monitor }}

# fix cursor
xsetroot -cursor_name left_ptr

# enable fonts
xset +fp {{ user_home }}/.local/share/fonts/
xset fp rehash

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# exec
shxkd &
exec dbus-launch bspwm
