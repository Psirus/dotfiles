import Skype4Py

skype = Skype4Py.Skype()
skype.Attach()

if len(skype.MissedMessages) == 0:
    print "^fg()0"
else:
    print "^fg(#FF0000)" + str(len(skype.MissedMessages))
