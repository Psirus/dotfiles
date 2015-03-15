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

pcmanfm -d &
urxvtd &
redshift -l 51.1:13.7 &

xsetroot -cursor_name left_ptr
feh --bg-scale ~/Bilder/Backgrounds/cat-and-tire.jpg
xset -b

xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation" 1
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Button" 2
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Timeout" 200

conky | dzen2 -x '1000' -y '0' -o '180' -h '24' -w '368' -fn 'Droid Sans:size=10' -ta 'r' -fg '#FFFFFF' -bg '#1B1D1E' &
export PATH=~/Code/Bash:~/Code/Fortran/fipps:/bin:/opt/intel/bin:$PATH
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

exec xmonad
