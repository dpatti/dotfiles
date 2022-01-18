import XMonad
import qualified XMonad.StackSet as W
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks (avoidStruts, docks)
import XMonad.Layout.Reflect (reflectVert)
import XMonad.Layout.Tabbed (simpleTabbed)
import XMonad.Layout.Fullscreen (fullscreenSupport)
-- import qualified XMonad.Util.Brightness as Brightness
import XMonad.Util.EZConfig (additionalKeys, additionalKeysP, removeKeysP)
import XMonad.Util.NamedScratchpad
import XMonad.Util.Run (safeSpawn, spawnPipe)
import XMonad.Config.Desktop
import System.IO (hPutStrLn)
import System.Exit (exitSuccess)

defaultLayout = Tall { tallNMaster = 1, tallRatioIncrement = 3/100, tallRatio = 1/2 }

layout = defaultLayout ||| reflectVert (Mirror defaultLayout) ||| simpleTabbed

terminalCommand = "urxvtc"

launcherKeys =
  [ ("M-S-l", spawn "slock")
  , ("M-S-<Return>", safeSpawn terminalCommand ["-e", "tmux"])
  , ("M-C-S-<Return>", safeSpawn terminalCommand [])
  ]

volumeKeys =
  [ ("<XF86AudioRaiseVolume>", spawn "pulseaudio-ctl up 5")
  , ("<XF86AudioLowerVolume>", spawn "pulseaudio-ctl down 5")
  , ("<XF86AudioMute>", spawn "pulseaudio-ctl mute")
  , ("<XF86AudioMicMute>", spawn "pulseaudio-ctl mute-input")
  -- , ("<XF86MonBrightnessDown>", Brightness.decrease)
  -- , ("<XF86MonBrightnessUp>", Brightness.increase)
  ]

incMasterKeys =
  [ ("M-S-[", sendMessage (IncMasterN 1))
  , ("M-S-]", sendMessage (IncMasterN (-1)))
  ]

quitKeys =
  [ ("M-C-S-q", io exitSuccess)
  ]

scratchpads =
  -- The 80% alpha doesn't work without an X compositor
  [ NS "term" "urxvtc -name scratchpad -depth 32 -bg '[80]#1d1f21' -e tmux" (resource =? "scratchpad")
       (customFloating $ W.RationalRect (1/5) (0/1) (3/5) (2/5))
  ]

scratchpadKeys =
  [ ("M-r", namedScratchpadAction scratchpads "term")
  ]

dunstKeys =
  [ ("C-<Space>", spawn "dunstctl close")
  , ("C-S-<Space>", spawn "dunstctl close-all")
  , ("C-`", spawn "dunstctl history-pop")
  , ("C-S-.", spawn "dunstctl context")
  ]

main = do
  xmobar <- spawnPipe "xmobar ~/.xmonad/xmobarrc"
  xmonad . fullscreenSupport . docks $ desktopConfig
    { layoutHook = avoidStruts layout
    , logHook = dynamicLogWithPP xmobarPP
      { ppOutput = hPutStrLn xmobar
      , ppTitle = xmobarColor "green" "" . shorten 50
      , ppOrder = take 1
      }
    , focusFollowsMouse = False
    , clickJustFocuses = False
    , terminal = terminalCommand
    , manageHook = namedScratchpadManageHook scratchpads
    }
    `additionalKeysP` (volumeKeys ++ launcherKeys ++ incMasterKeys ++ quitKeys ++ scratchpadKeys ++ dunstKeys)
    `removeKeysP` ["M-,", "M-.", "M-S-q"]
