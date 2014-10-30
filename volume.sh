amixer get Master | tail -1 | sed 's/.*\(-[0-9]\+.[0-9]\+dB\).*/\1/'
