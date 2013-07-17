# coding: utf-8
""" Output info about current song and volume, to be piped into xfce's
genmon panel plugin """
import dbus
import subprocess
import sys
import re

bus = dbus.SessionBus()
try:
    gmusicbrowser = bus.get_object("org.gmusicbrowser", "/org/gmusicbrowser")
except dbus.exceptions.DBusException:
    print " "
    sys.exit()

current_track = gmusicbrowser.CurrentSong()
title = current_track.get("title").encode('utf-8')
artist = current_track.get("artist").encode('utf-8')
album = current_track.get("album").encode('utf-8')

volumeProcess = subprocess.Popen('amixer get Master | grep dB', shell=True, 
                                 stdout=subprocess.PIPE)
volume = volumeProcess.stdout.readline()
volumeProcess.terminate()
volString = re.findall("\d*.\d*dB", volume)[0][0:-2]

print artist + ": " + title + " in " + album + "; -" + volString + "dB"
