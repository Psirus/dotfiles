import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.SetWMName
import XMonad.Hooks.Place
import XMonad.Hooks.DynamicLog
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Layout.Fullscreen
import XMonad.Prompt
import XMonad.Prompt.AppendFile
import XMonad.Util.Loggers
import XMonad.Util.Dzen
import XMonad.Util.Run
import Data.Monoid
import Graphics.X11.ExtraTypes.XF86
import System.Exit
import System.Posix.Unistd

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

myTerminal      = "xfce4-terminal"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses = False

myBorderWidth   = 2

myModMask       = mod1Mask

myWorkspaces            :: [String]
myWorkspaces            = clickable . (map dzenEscape) $ ["I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"]
 
  where clickable l     = [ "^ca(1,xdotool key alt+" ++ show (n) ++ ")" ++ ws ++ "^ca()" |
                            (i,ws) <- zip [1..] l,
                            let n = i ]


myNormalBorderColor  = "#888888"
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
      , ppOrder           = \(ws:l:t) -> [ws]
      , ppOutput          = hPutStrLn h
    }

myLogHook2 h = dynamicLogWithPP $ defaultPP
    {
        ppSep    = "  |  "
      , ppOrder  = \(ws:l:t:e) -> [t]
      , ppTitle  = (" " ++) . dzenColor "white" "#1B1D1E" . dzenEscape
      , ppOutput = hPutStrLn h
    }

appendfile = do
    appendFilePrompt defaultXPConfig notesFile
    where
        notesFile = "/home/psirus/Dokumente/Diverses/notes.md"

amixer hostname = "amixer " ++ card ++ "set Master "
    where
        card = case hostname of
            "psirus-laptop" -> "-c 1 "
            "psirus-desktop" -> "-c 0 "

raiseVolume hostname = spawn $ amixer hostname ++ "3dB+"
lowerVolume hostname = spawn $ amixer hostname ++ "3dB-"

myKeys hostname conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- launch xfrun4
    , ((modm,               xK_p     ), spawn "dmenu_run -h '24' -fn 'Droid Sans:size=10' -sb '#A91919' -nb '#1B1D1E' -nf '#FFFFFF'")

    -- launch conky
    , ((modm,               xK_f     ), spawn "conky")
    , ((modm,               xK_g     ), spawn "banshee & sleep 5 && conky -c .conkyrc2")
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
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

--    -- Increment the number of windows in the master area
--    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))
--
--    -- Deincrement the number of windows in the master area
--    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")

    -- Turn off monitors
    , ((modm              , xK_x     ), spawn "sleep 0.2 && xset dpms force off")

    -- Toggle Play/Pause
    , ((0,           xF86XK_AudioPlay), spawn "banshee --toggle-playing")

    -- Next track
    , ((0,           xF86XK_AudioNext), spawn "banshee --next")

    -- Previous track
    , ((0,           xF86XK_AudioPrev), spawn "banshee --restart-or-previous") 

    -- Lower Volume
    , ((0, xF86XK_AudioLowerVolume), lowerVolume hostname)

    -- Raise Volume
    , ((0, xF86XK_AudioRaiseVolume), raiseVolume hostname)

    -- Prompt to append a sinle line of text to a file
    , ((modm .|. controlMask, xK_n   ), appendfile)
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
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
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

myLayout = (smartSpacing 7 $ avoidStruts $ (
    tiled ||| 
    Mirror tiled )) |||  
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
    ]

myEventHook = ewmhDesktopsEventHook

--myLogHook = ewmhDesktopsLogHook

-- needed for matlab to work with XMonad
myStartupHook = ewmhDesktopsStartup

toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)
myXmonadBar = "dzen2 -x '0' -y '0' -o '170' -h '24' -w '185' -fn 'Droid Sans:size=10' -ta 'l' -fg '#FFFFFF' -bg '#1B1D1E'"
myXmonadBar2 = "dzen2 -x '185' -y '0' -o '170' -h '24' -w '998' -fn 'Droid Sans:size=10' -ta 'c' -fg '#FFFFFF' -bg '#1B1D1E'"

main = do
    dzenBar <- spawnPipe myXmonadBar
    dzenBar2 <- spawnPipe myXmonadBar2
    hostname <- fmap nodeName getSystemID
    xmonad $ defaultConfig {
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,
        keys               = myKeys hostname,
        mouseBindings      = myMouseBindings,
        layoutHook         = myLayout,
        manageHook         = manageDocks <+> myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook dzenBar <+> myLogHook2 dzenBar2,
        startupHook        = myStartupHook
        }
