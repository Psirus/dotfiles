import XMonad
import XMonad.Util.EZConfig
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Hooks.ManageDocks
import XMonad.Config.Desktop
import Graphics.X11.ExtraTypes.XF86

myLayout = avoidStruts (
    Tall 1 (2/100) (1/2) |||
    Mirror (Tall 1 (2/100) (1/2))) |||
    noBorders (fullscreenFull Full)

main = xmonad $ desktopConfig
	{ terminal = "xfce4-terminal"
    , focusedBorderColor = "#79a142"
    , layoutHook = myLayout
	} `additionalKeys`
	[ ((mod1Mask, xK_F4), kill)
    , ((mod1Mask .|. shiftMask, xK_q), spawn "xfce4-session-logout")
    , ((0, xF86XK_AudioNext), spawn "quodlibet --next")
    , ((0, xF86XK_AudioPrev), spawn "quodlibet --previous")
    , ((0, xF86XK_AudioPlay), spawn "quodlibet --play-pause")
    ]
