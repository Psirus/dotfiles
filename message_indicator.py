#!/usr/bin/env python2
# -*- coding: utf-8
import Skype4Py
import subprocess
import re

skypeRunning = False
s = subprocess.Popen(["ps","axw"],stdout=subprocess.PIPE)
for x in s.stdout:
    if re.search("skype", x):
        skypeRunning = True

if skypeRunning:
    skype = Skype4Py.Skype()
    skype.Attach()
    icon = "^fg(#00adef)਀ "
    if len(skype.MissedMessages) == 0:
        print icon + "^fg()0"
    else:
        print icon + "^fg(#FF0000)" + str(len(skype.MissedMessages))
