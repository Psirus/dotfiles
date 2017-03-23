import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.SetWMName
import XMonad.Hooks.Place
import XMonad.Hooks.DynamicLog
import XMonad.Layout.NoBorders
import XMonad.Layout.Grid
import XMonad.Layout.Fullscreen
import XMonad.Layout.MouseResizableTile
import XMonad.Util.Loggers
import XMonad.Util.Run
import Graphics.X11.ExtraTypes.XF86
import System.Posix.Unistd

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

myTerminal :: String
myTerminal = "gnome-terminal"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

myWorkspaces :: [String]
myWorkspaces = ["I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"]

myNormalBorderColor :: String
myNormalBorderColor = "#888888"
myFocusedBorderColor :: String
myFocusedBorderColor = "#A91919"

myLogHook h = dynamicLogWithPP $ defaultPP
    {
        ppCurrent         = xmobarColor "#A91919" "#1B1D1E" . const "■"
      , ppVisible         = xmobarColor "white" "#1B1D1E" . const "■"
      , ppHidden          = xmobarColor "grey" "#1B1D1E" . const "■"
      , ppHiddenNoWindows = xmobarColor "#555555" "#1B1D1E" . const "■"
--      , ppHiddenNoWindows = const ""
      , ppUrgent          = xmobarColor "#ff0000" "#1B1D1E"
      , ppWsSep           = " "
      , ppSep             = ""
      , ppOrder           = \(ws:l:t:e) -> [ws]
      , ppOutput          = hPutStrLn h
    }

titlePP = defaultPP {
       ppTitle           = xmobarColor "#849308" "" . pad . shorten 70
      , ppOrder           = \(ws:l:t:e) -> [t]
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
    , ((modm,               xK_p     ), spawn "dmenu_run -fn 'Droid Sans:size=10' -sb '#A91919' -nb '#1B1D1E' -nf '#FFFFFF'")

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

    -- Open czech grammar
    , ((modm,               xK_c     ), spawn "zathura ~/Dokumente/Prag/Czech\\ An\\ Essential\\ Grammar.pdf & sh -c 'cd ~/Wiki/wikidata/Czech && nvim-wrapper .'")

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")

    -- Turn off monitors
    , ((modm              , xK_x     ), spawn "sleep 0.2 && xset dpms force off")

    -- Toggle Play/Pause
    , ((0,           xF86XK_AudioPlay), spawn "mpc toggle")

    -- Next track
    , ((0,           xF86XK_AudioNext), spawn "mpc next")

    -- Previous track
    , ((0,           xF86XK_AudioPrev), spawn "mpc prev")

    -- Lower Volume
    , ((0, xF86XK_AudioLowerVolume), lowerVolume hostname)

    -- Raise Volume
    , ((0, xF86XK_AudioRaiseVolume), raiseVolume hostname)

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
        | (key, sc) <- zip [xK_e, xK_w] [0..]
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

myLayout = (avoidStruts $ mouseResizableTile{ draggerType = BordersDragger }) |||  
    noBorders (fullscreenFull Full) 

myManageHook = composeAll
    [ className =? "Pidgin"         --> doFloat
    , className =? "Skype"          --> doFloat
    , className =? "feh"          --> doIgnore
    ]

myEventHook = ewmhDesktopsEventHook

-- needed for Java Applications to work with XMonad
myStartupHook hostname = ewmhDesktopsStartup <+> spawn "compton" <+> setWMName "LG3D"

toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)
myXmonadBar = "xmobar"

main = do
    hostname <- fmap nodeName getSystemID
    xmobar <- spawnPipe myXmonadBar
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
        logHook            = myLogHook xmobar <+> (dynamicLogString titlePP >>= xmonadPropLog),
        startupHook        = myStartupHook hostname
        }
