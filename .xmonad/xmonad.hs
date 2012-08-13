import XMonad
import XMonad.Util.EZConfig
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Hooks.ManageDocks
import XMonad.Config.Desktop

import qualified Data.Map as M

myLayout = avoidStruts (
    Tall 1 (3/100) (1/2) |||
    Mirror (Tall 1 (3/100) (1/2))) |||
    noBorders (fullscreenFull Full)

main = xmonad $ desktopConfig
	{ terminal = "xfce4-terminal",
    layoutHook = myLayout
	} `additionalKeys`
	[ ((mod1Mask, xK_F4), kill)
    , ((mod1Mask, xK_b), spawn "dmenu_run")
    , ((mod1Mask .|. shiftMask, xK_q), spawn "xfce4-session-logout")
    ]
