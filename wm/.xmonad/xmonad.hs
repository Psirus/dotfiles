import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.SetWMName
import XMonad.Hooks.Place
import XMonad.Hooks.DynamicLog
import XMonad.Layout.NoBorders
import XMonad.Layout.Grid
import XMonad.Layout.EqualSpacing
import XMonad.Layout.BinarySpacePartition
import XMonad.Layout.Fullscreen
import XMonad.Util.Loggers
import XMonad.Util.Dzen
import XMonad.Util.Run
import Graphics.X11.ExtraTypes.XF86
import System.Posix.Unistd

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

myTerminal :: String
myTerminal = "urxvt"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

myWorkspaces :: [String]
myWorkspaces            = clickable . (map dzenEscape) $ ["I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"]
 
  where clickable l     = [ "^ca(1,xdotool key alt+" ++ show (n) ++ ")" ++ ws ++ "^ca()" |
                            (i,ws) <- zip [1..] l,
                            let n = i ]

myNormalBorderColor :: String
myNormalBorderColor = "#888888"
myFocusedBorderColor :: String
myFocusedBorderColor = "#A91919"

myLogHook h = dynamicLogWithPP $ defaultPP
    {
        ppCurrent         = dzenColor "#A91919" "#1B1D1E" . pad
      , ppVisible         = dzenColor "white" "#1B1D1E" . pad
      , ppHidden          = dzenColor "white" "#1B1D1E" . pad
      , ppHiddenNoWindows = const ""
      , ppUrgent          = dzenColor "#ff0000" "#1B1D1E" . pad
      , ppWsSep           = " "
      , ppSep             = "  |  "
      , ppOrder           = \(ws:l:t:e) -> [ws,t]
      , ppOutput          = hPutStrLn h
    }

amixer hostname = "amixer " ++ card ++ "set Master "
    where
        card = case hostname of
            "psirus-laptop" -> "-c 1 "
            "psirus-desktop" -> "-c 0 "

raiseVolume hostname = spawn $ amixer hostname ++ "3dB+"
lowerVolume hostname = spawn $ amixer hostname ++ "3dB-"

ctrlMask = controlMask

myKeys hostname conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- launch xfrun4
    , ((modm,               xK_p     ), spawn "dmenu_run -h '24' -fn 'Droid Sans:size=10' -sb '#A91919' -nb '#1B1D1E' -nf '#FFFFFF'")

    -- close focused window
    , ((modm,               xK_F4    ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_r     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_g     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")

    -- Turn off monitors
    , ((modm              , xK_x     ), spawn "sleep 0.2 && xset dpms force off")

    -- Toggle Play/Pause
    , ((0,           xF86XK_AudioPlay), spawn "cmus-remote --pause")

    -- Next track
    , ((0,           xF86XK_AudioNext), spawn "cmus-remote --next")

    -- Previous track
    , ((0,           xF86XK_AudioPrev), spawn "cmus-remote --prev")

    -- Lower Volume
    , ((0, xF86XK_AudioLowerVolume), lowerVolume hostname)

    -- Raise Volume
    , ((0, xF86XK_AudioRaiseVolume), raiseVolume hostname)

    , ((modm, xK_n), sendMessage $ LessSpacing)
    , ((modm .|. shiftMask, xK_n), sendMessage $ MoreSpacing)
    , ((modm .|. controlMask, xK_n), sendMessage $ DefaultSpacing)
    , ((modm .|. controlMask .|. shiftMask, xK_n), sendMessage $ NoSpacing)

    , ((modm .|. shiftMask,               xK_l     ), sendMessage $ ExpandTowards R)
    , ((modm .|. shiftMask,               xK_h     ), sendMessage $ ExpandTowards L)
    , ((modm .|. shiftMask,               xK_j     ), sendMessage $ ExpandTowards D)
    , ((modm .|. shiftMask,               xK_k     ), sendMessage $ ExpandTowards U)

    , ((modm,                           xK_r     ), sendMessage Rotate)
    , ((modm,                           xK_s     ), sendMessage Swap)
    
    ]
    ++

    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $
    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))
    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))
    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))
    ]

myLayout = (equalSpacing 36 6 0 1 $ avoidStruts $ (
    emptyBSP |||
    GridRatio 1.1 ||| 
    tiled )) |||  
    noBorders (fullscreenFull Full) 
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio
     -- The default number of windows in the master pane
     nmaster = 1
     -- Default proportion of screen occupied by master pane
     ratio   = 1/2
     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

myManageHook = composeAll
    [ className =? "Pidgin"         --> doFloat
    , className =? "Skype"          --> doFloat
    , className =? "banshee"          --> doFloat
    , className =? "feh"          --> doIgnore
    ]

myEventHook = ewmhDesktopsEventHook


leftBar :: String -> String
leftBar hostname = ""
--    | hostname == "psirus-desktop" = "conky | dzen2 -x '1000' -y '0' -o '180' -h '24' -w '680' -fn 'Droid Sans:size=10' -ta 'r' -fg '#FFFFFF' -bg '#1B1D1E'"
--    | otherwise = ""

-- needed for Java Applications to work with XMonad
myStartupHook hostname = ewmhDesktopsStartup <+> spawn "compton" <+> spawn "setxkbmap de neo" <+> setWMName "LG3D" <+> spawn (leftBar hostname)

toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)
myXmonadBar hostname
    | hostname == "psirus-laptop" = "dzen2 -x '0' -y '0' -o '180' -h '24' -w '700' -fn 'Droid Sans:size=10' -ta 'l' -fg '#FFFFFF' -bg '#1B1D1E'"
    | hostname == "psirus-desktop" = "dzen2 -x '0' -y '0' -o '180' -h '24' -w '1000' -fn 'Droid Sans:size=10' -ta 'l' -fg '#FFFFFF' -bg '#1B1D1E'"
    | otherwise = ""

main = do
    hostname <- fmap nodeName getSystemID
    dzenBar <- spawnPipe (myXmonadBar hostname)
    xmonad $ defaultConfig {
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = 2,
        modMask            = mod1Mask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,
        keys               = myKeys hostname,
        mouseBindings      = myMouseBindings,
        layoutHook         = myLayout,
        manageHook         = manageDocks <+> myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook dzenBar,
        startupHook        = myStartupHook hostname
        }
