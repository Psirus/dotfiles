export XKB_DEFAULT_LAYOUT=de
export XKB_DEFAULT_VARIANT=neo
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec sway
