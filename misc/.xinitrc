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
mpd .mpdconf &

xsetroot -cursor_name left_ptr &
xset -b &
if [ "$HOSTNAME" = "psirus-laptop" ]; then
    feh --bg-scale ~/Bilder/Backgrounds/cat-and-tire.jpg &
    xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation" 1
    xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Button" 2
    xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Timeout" 200
    dzen_start="1000"
    dzen_width="368"
elif [ "$HOSTNAME" = "psirus-desktop" ]; then
    xrandr --output VGA-0 --right-of DVI-0
    feh --bg-max --no-xinerama ~/Bilder/Backgrounds/Dualscreen/pikespeak.jpg &
    dzen_start="1300"
    dzen_width="380"
fi

conky | dzen2 -x $dzen_start -y '0' -o '180' -h '24' -w $dzen_width -fn 'Barfont:size=10' -ta 'r' -fg '#FFFFFF' -bg '#1B1D1E' &
export PATH=~/Code/Bash:~/Code/Fortran/fipps:/bin:/opt/intel/bin:$PATH
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

exec xmonad
