import XMonad
import System.IO
import XMonad.Util.EZConfig
import XMonad.Util.Run
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Config.Desktop
import Graphics.X11.ExtraTypes.XF86
import XMonad.Hooks.DynamicLog

myWorkspaces = ["I","II","III","IV","V","VI","VII","VIII","IX"]

myLayout = avoidStruts (
    Tall 1 (2/100) (1/2) |||
    Mirror (Tall 1 (2/100) (1/2))) |||
    noBorders (fullscreenFull Full)

myLogHook h = dynamicLogWithPP $ defaultPP
    { ppOutput = hPutStrLn h
    , ppCurrent = dzenColor "#79a142" "#121212" . pad
    , ppWsSep = " | "
    }

myStatusDzen = "~/.xmonad/dzenInput.py | dzen2 -x '1680' -y '0' -h '24' -w '1680' -fn 'DejaVu Sans:size=10'"

myLogDzen = "dzen2 -x '0' -y '0' -h '24' -w '1680' -fn 'DejaVu Sans:size=10'"
main = do
    h <- spawnPipe myLogDzen
    spawnPipe myStatusDzen
    xmonad $ desktopConfig
	  { terminal = "gnome-terminal"
      , focusedBorderColor = "#79a142"
      , layoutHook = myLayout
      , logHook = myLogHook h
      , startupHook = setWMName "LG3D"
      , workspaces = myWorkspaces
	  } `additionalKeys`
	  [ ((mod1Mask, xK_F4), kill)
      , ((0, xF86XK_AudioNext), spawn "banshee --next")
      , ((0, xF86XK_AudioPrev), spawn "banshee --restart-or-previous")
      , ((0, xF86XK_AudioPlay), spawn "banshee --toggle-playing")
      , ((0, xF86XK_AudioLowerVolume), spawn "amixer set Master 3dB-")
      , ((0, xF86XK_AudioRaiseVolume), spawn "amixer set Master 3dB+")
      , ((mod1Mask, xK_p), spawn "dmenu_run")
      ]
