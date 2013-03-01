#!/usr/bin/python
import time
import sys
import subprocess
import dbus
import re
import matplotlib as mpl
import matplotlib.cm as cm
import matplotlib.colors as colors

bus = dbus.SessionBus()
banshee = bus.get_object("org.bansheeproject.Banshee", "/org/bansheeproject/Banshee/PlayerEngine")

def getColor(x):
    norm = mpl.colors.Normalize(vmin=-42, vmax=-9)
    cmap = cm.RdYlGn_r
    m = cm.ScalarMappable(norm=norm, cmap=cmap)
    colorRGB = m.to_rgba(x)[0:3]
    return colors.rgb2hex(colorRGB)

def getMusicInfo():
    if banshee.GetCurrentState() == dbus.String(u'idle'):
        return "Not playing anything"

    currentTrack = banshee.GetCurrentTrack()
    artist = currentTrack['artist'].encode('utf-8')
    title = "^fg(#79a142)" + currentTrack['name'].encode('utf-8')

    volumeProcess = subprocess.Popen('amixer get Master | grep dB', shell=True, stdout=subprocess.PIPE)
    volume = volumeProcess.stdout.readline()
    regExp = re.compile('-(.*?)dB')
    volumeDouble = -1.0 * float(regExp.search(volume).group(1))
    fgcolor = getColor(volumeDouble)
    volumeProcess.terminate()

    return artist + ": " + title + " ^fg(" + fgcolor + ")" + str(volumeDouble) + "dB"

time.sleep(5)
while True:
    currentTime = time.strftime("%H:%M")
    musicInfo = getMusicInfo()
    sys.stdout.write(musicInfo + "    ^fg(#ffffff)" + currentTime + "\n")
    sys.stdout.flush()
    time.sleep(1)
