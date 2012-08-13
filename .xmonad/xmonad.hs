import XMonad
import XMonad.Util.EZConfig
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Hooks.ManageDocks
import XMonad.Config.Desktop

myLayout = avoidStruts (
    Tall 1 (3/100) (1/2) |||
    Mirror (Tall 1 (3/100) (1/2))) |||
    noBorders (fullscreenFull Full)

main = xmonad $ desktopConfig
	{ terminal = "xfce4-terminal"
    , focusedBorderColor = "#79a142"
    , layoutHook = myLayout
	} `additionalKeys`
	[ ((mod1Mask, xK_F4), kill)
    , ((mod1Mask .|. shiftMask, xK_q), spawn "xfce4-session-logout")
    ]
