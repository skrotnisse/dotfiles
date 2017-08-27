#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Parse the ~/.Xresources configuration file.
xrdb -merge ~/.Xresources

# Setup wallpaper.
exec feh --recursive --randomize --bg-center ~/wallpapers/* &

# Start the i3 window manager.
exec i3 -c ~/.i3/config -V >> ~/.i3logs/log-$(date +%Y-%m-%d.%H:%M) 2>&1
