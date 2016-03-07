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

pulseaudio --start &
mpd .mpdconf &
pcmanfm -d &
redshift -l 51.1:13.7 &

setxkbmap de neo &
xsetroot -cursor_name left_ptr &
xset -b &
if [ "$HOSTNAME" = "psirus-laptop" ]; then
    .screenlayout/extern_left.sh
    feh --bg-scale ~/Bilder/Backgrounds/bg_img5.jpg &
    xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation" 1
    xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Button" 2
    xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Timeout" 200
    dzen_start="700"
    dzen_width="668"
elif [ "$HOSTNAME" = "psirus-desktop" ]; then
    xrandr --output VGA-0 --right-of DVI-0
    feh --bg-max --no-xinerama ~/Bilder/Backgrounds/Dualscreen/pikespeak.jpg &
    dzen_start="1000"
    dzen_width="680"
fi

export PATH=~/.gem/ruby/2.3.0/bin:~/Code/Python/altay:~/.cabal/bin:~/Code/Bash:/usr/local/texlive/2014/bin/x86_64-linux:$PATH
export OSFONTDIR=/usr/share/fonts:$HOME/.fonts
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

exec xmonad
#exec startxfce4
#exec startkde
