import time
import mpd
import subprocess

class Color(object):

    def __init__(self, fg, bg):
        self.fg = fg
        self.bg = bg

color1 = Color("#ff086994", "#ff222222")
color2 = Color("#ff849308", "#ff363636")
color3 = Color("#ff8F081A", "#ff222222")
color4 = Color("#ff9e9e9e", "#ff303030")

def date():
    day_abbr = time.strftime("%a")
    day_number = time.strftime("%d")
    hour = time.strftime("%H")
    minute = time.strftime("%M")
    return "{0}.{1}  {2}:{3}".format(day_abbr, day_number, hour, minute)

def current_song(mpd_client):
    song = mpd_client.currentsong()
    if song:
        return "{0} - {1}".format(song.get('artist'), song.get('title'))
    else:
        return None

def batter_percent():
    cmd = r"acpi -b | awk '{ print $4, $5}'"
    acpi = subprocess.check_output(cmd, shell=True)
    return acpi[:-1].decode()

def get_volume():
    cmd = r"amixer -c 1 get Master | grep dB | sed 's/.*\[\(.*dB\).*/\1/g'"
    amixer = subprocess.check_output(cmd, shell=True)
    return amixer[:-1].decode()

def trans_to_color(color):
    return "%{{F{0}}}".format(color)

def color_format(foreground, background):
    return "%{{F{0}}}%{{B{1}}} ".format(foreground, background)

def transition(color1, color2):
    return "%{{F{0}}}%{{B{1}}}".format(color2, color1)


if __name__ == "__main__":
    connection = False

    while True:
        if not connection:
            try:
                mpd_client = mpd.MPDClient()
                mpd_client.connect("localhost", 6600)
            except ConnectionRefusedError:
                pass
            else:
                connection = True
        current_date = date()
        if connection:
            song = current_song(mpd_client)
        else:
            song = None
        battery = batter_percent()
        volume = get_volume()
        if song:
            print(("%{r}" + trans_to_color(color1.bg) 
                   + color_format(color1.fg, color1.bg) + song + " " 
                   + transition(color1.bg, color2.bg)
                   + color_format(color2.fg, color2.bg) + volume + " " 
                   + transition(color2.bg, color3.bg)
                   + color_format(color3.fg, color3.bg) + battery
                   + transition(color3.bg, color4.bg)
                   + color_format(color4.fg, color4.bg) + current_date 
                   + " %{F-B-}"))
        else:
            print(("%{r}" + trans_to_color(color2.bg) 
                   + color_format(color2.fg, color2.bg) + volume + " " 
                   + transition(color2.bg, color3.bg)
                   + color_format(color3.fg, color3.bg) + battery
                   + transition(color3.bg, color4.bg)
                   + color_format(color4.fg, color4.bg) + current_date 
                   + " %{F-B-}"))
        time.sleep(1)
