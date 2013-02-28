#!/usr/bin/python
import time
import sys
import subprocess
import re

def getMusicInfo():
    artProcess = subprocess.Popen('banshee --query-artist', shell=True, stdout=subprocess.PIPE)
    artist = artProcess.stdout.readline()
    artProcess.terminate()
    artist = artist[8:len(artist)-1]

    titleProcess = subprocess.Popen('banshee --query-title', shell=True, stdout=subprocess.PIPE)
    title = titleProcess.stdout.readline()
    titleProcess.terminate()
    title = title[7:len(title)-1]

    volumeProcess = subprocess.Popen('amixer get Master | grep dB', shell=True, stdout=subprocess.PIPE)
    volume = volumeProcess.stdout.readline()
    regExp = re.compile('-(.*?)dB')
    volume = " -" + regExp.search(volume).group(1) + "dB"
    volumeProcess.terminate()
    return artist + ": " + title + volume

while True:
    currentTime = time.strftime("%H:%M")
    musicInfo = getMusicInfo()
    sys.stdout.write(currentTime + " " + musicInfo + "\n")
    sys.stdout.flush()
    time.sleep(1)
