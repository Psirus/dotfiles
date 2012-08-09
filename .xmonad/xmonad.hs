import XMonad
import XMonad.Util.EZConfig
import XMonad.Config.Xfce

main = xmonad $ xfceConfig
	{ terminal = "xfce4-terminal"
	} `additionalKeys`
	[ ((mod1Mask, xK_F4), kill)
	]
