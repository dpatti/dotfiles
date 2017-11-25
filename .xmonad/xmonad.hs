import XMonad
import qualified XMonad.StackSet as W
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks (avoidStruts, docks)
import XMonad.Layout.Reflect (reflectVert)
import XMonad.Layout.Tabbed (simpleTabbed)
import XMonad.Layout.Fullscreen (fullscreenSupport)
import XMonad.Util.EZConfig (additionalKeys, additionalKeysP, removeKeysP)
import XMonad.Util.Run (spawnPipe)
import XMonad.Config.Desktop
import System.IO (hPutStrLn)
import System.Exit (exitWith, ExitCode(..))

defaultLayout = Tall { tallNMaster = 1, tallRatioIncrement = 3/100, tallRatio = 1/2 }

layout = defaultLayout ||| reflectVert (Mirror defaultLayout) ||| simpleTabbed

launcherKeys =
  [ ("M-S-l", spawn "xscreensaver-command -lock")
  ]

volumeKeys =
  [ ("<XF86AudioRaiseVolume>", spawn "pulseaudio-ctl up 5")
  , ("<XF86AudioLowerVolume>", spawn "pulseaudio-ctl down 5")
  , ("<XF86AudioMute>", spawn "pulseaudio-ctl mute")
  ]

incMasterKeys =
  [ ("M-S-[", sendMessage (IncMasterN 1))
  , ("M-S-]", sendMessage (IncMasterN (-1)))
  ]

quitKeys =
  [ ("M-C-S-q", io (exitWith ExitSuccess))
  ]
main = do
  xmobar <- spawnPipe "xmobar ~/.xmonad/xmobarrc"
  xmonad . fullscreenSupport . docks $ desktopConfig
    { layoutHook = avoidStruts layout
    , logHook = dynamicLogWithPP xmobarPP
      { ppOutput = hPutStrLn xmobar
      , ppTitle = xmobarColor "green" "" . shorten 50
      }
    , focusFollowsMouse = False
    , clickJustFocuses = False
    , terminal = "urxvtc"
    }
    `additionalKeysP` (volumeKeys ++ launcherKeys ++ incMasterKeys ++ quitKeys)
    `removeKeysP` ["M-,", "M-.", "M-S-q"]
