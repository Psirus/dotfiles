import XMonad
import System.IO
import System.Posix.Unistd
import XMonad.Util.EZConfig
import XMonad.Util.Run
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Config.Desktop
import Graphics.X11.ExtraTypes.XF86
import XMonad.Hooks.DynamicLog

myWorkspaces = ["music","chat","web","email","vim","misc","VII","VIII","IX"]

myLayout = avoidStruts (
    Tall 1 (2/100) (1/2) |||
    Mirror (Tall 1 (2/100) (1/2))) |||
    noBorders (fullscreenFull Full)

myLogHook h = dynamicLogWithPP $ defaultPP
    { ppOutput = hPutStrLn h
    , ppTitle = dzenColor "#79a142" "#272822"
    , ppCurrent = dzenColor "#79a142" "#272822"
    , ppVisible = dzenColor "#8da171" "#272822"
    , ppWsSep = " | "
    , ppLayout = (\ x -> "")
    }

myManageHook = composeAll
    [ className =? "Pidgin" --> doFloat
    , className =? "Skype" --> doFloat
    ]

myStatusDzen hostname = "~/.xmonad/dzenInput.py | dzen2 -x " ++ xPos ++ " -y " ++ yPos ++" -h '24' -w " ++ width ++ " -fn 'DejaVu Sans:size=10'"
    where
        width = case hostname of
            "psirus-laptop" -> "1366"
            "psirus-desktop" -> "1680"
        xPos = case hostname of
            "psirus-laptop" -> "0"
            "psirus-desktop" -> "1680"
        yPos = case hostname of
            "psirus-laptop" -> "744"
            "psirus-desktop" -> "0"

--myPymodoroDzen = "~/.xmonad/pymodoro.py | dzen2 -x '1680' -y '24' -h '24' -w '1680' -fn 'DejaVu Sans:size=10'"
myLogDzen hostname = "dzen2 -x '0' -y '0' -h '24' -w " ++ width ++ " -bg '#272822' -fn 'DejaVu Sans:size=10'"
    where
        width = case hostname of
            "psirus-laptop" -> "1366"
            "psirus-desktop" -> "1680"

raiseVolume hostname = spawn $ "amixer " ++ card ++ "set Master 3dB+"
    where 
        card = case hostname of
	    "psirus-laptop" -> "-c 1 "
	    "psirus-desktop" -> " "

lowerVolume hostname = spawn $ "amixer " ++ card ++ "set Master 3dB-"
    where 
        card = case hostname of
	    "psirus-laptop" -> "-c 1 "
	    "psirus-desktop" -> " "
main = do
    hostname <- fmap nodeName getSystemID
    h <- spawnPipe $ myLogDzen hostname
    spawnPipe $ myStatusDzen hostname
--    spawnPipe myPymodoroDzen
    xmonad $ desktopConfig
      { terminal = "gnome-terminal"
      , focusedBorderColor = "#79a142"
      , layoutHook = myLayout
      , logHook = myLogHook h
      , manageHook = myManageHook
        -- needed for matlab to work with XMonad
      , startupHook = setWMName "LG3D"
      , workspaces = myWorkspaces
	  } `additionalKeys`
	  [ ((mod1Mask, xK_F4), kill)
      , ((mod1Mask, xK_x), spawn "sleep 0.2 && xset dpms force off")
      , ((0, xF86XK_AudioNext), spawn "banshee --next")
      , ((0, xF86XK_AudioPrev), spawn "banshee --restart-or-previous")
      , ((0, xF86XK_AudioPlay), spawn "banshee --toggle-playing")
      , ((0, xF86XK_AudioLowerVolume), lowerVolume hostname)
      , ((0, xF86XK_AudioRaiseVolume), raiseVolume hostname)
      , ((mod1Mask, xK_p), spawn "dmenu_run -nb '#000000' -nf '#79a142' -fn 'DejaVu Sans:size=10'")
      ]
