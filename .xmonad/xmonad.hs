import XMonad
import XMonad.Util.EZConfig
import XMonad.Config.Xfce
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Hooks.ManageDocks

myLayout = avoidStruts (
    Tall 1 (3/100) (1/2) |||
    Mirror (Tall 1 (3/100) (1/2))) |||
    noBorders (fullscreenFull Full)

main = xmonad $ xfceConfig
	{ terminal = "xfce4-terminal",
    layoutHook = myLayout
	} `additionalKeys`
	[ ((mod1Mask, xK_F4), kill)
	]
