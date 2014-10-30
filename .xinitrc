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

setxkbmap de neo
xsetroot -cursor_name left_ptr
feh --bg-scale Bilder/Backgrounds/Eigene/nr2014_1.jpg
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation" 1
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Button" 2
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Timeout" 200
export PATH=~/Code/Bash:~/Code/Fortran/fipps:/bin:/opt/intel/bin:$PATH
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
compton &
conky | dzen2 -x '1183' -y '0' -o '170' -h '24' -w '184' -fn 'Droid Sans:size=10' -ta 'r' -fg '#FFFFFF' -bg '#1B1D1E' &

# exec gnome-session
# exec startkde
#exec startxfce4
exec xmonad
# ...or the Window Manager of your choice
