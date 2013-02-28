#!/usr/bin/python
import time
import sys
import subprocess

def getMusicInfo():
    artProcess = subprocess.Popen('banshee --query-artist', shell=True, stdout=subprocess.PIPE)
    artist = artProcess.stdout.readline()
    artist = artist[8:len(artist)-1]

    titleProcess = subprocess.Popen('banshee --query-title', shell=True, stdout=subprocess.PIPE)
    title = titleProcess.stdout.readline()
    title = title[7:len(title)-1]
    return artist + ": " + title

while True:
    currentTime = time.strftime("%H:%M")
    musicInfo = getMusicInfo()
    sys.stdout.write(currentTime + " " + musicInfo + "\n")
    sys.stdout.flush()
    time.sleep(1)
