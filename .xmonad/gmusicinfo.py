# coding: utf-8
import dbus

bus = dbus.SessionBus()
gmusicbrowser = bus.get_object("org.gmusicbrowser", "/org/gmusicbrowser")

current_track = gmusicbrowser.CurrentSong()
title = current_track.get("title").encode('utf-8')
artist = current_track.get("artist").encode('utf-8')
album = current_track.get("album").encode('utf-8')

print artist + ": " + title + " in " + album
