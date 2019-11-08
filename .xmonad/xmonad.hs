import qualified Data.Map as M

import XMonad
import qualified XMonad.StackSet as W  -- myManageHookShift

import Control.Monad (liftM2)          -- myManageHookShift
import System.IO                       -- for xmobar

import XMonad.Actions.WindowGo
import XMonad.Actions.FloatKeys
import XMonad.Actions.CycleWS
import qualified XMonad.Actions.FlexibleResize as Flex  -- Resize floating windows from any corner
import XMonad.Hooks.DynamicLog         -- for xmobar
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.FadeWindows
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageDocks        -- avoid xmobar area
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.Place
import XMonad.Layout
import XMonad.Layout.DecorationMadness
import XMonad.Layout.DragPane          -- see only two window
import XMonad.Layout.Gaps
import XMonad.Layout.Grid
import XMonad.Layout.IM
import qualified XMonad.Layout.Magnifier as Mag -- this makes window bigger
import XMonad.Layout.Fullscreen
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.Named
import XMonad.Layout.NoBorders         -- In Full mode, border is no use
import XMonad.Layout.PerWorkspace      -- Configure layouts on a per-workspace
import XMonad.Layout.ResizableTile     -- Resizable Horizontal border
import XMonad.Layout.ShowWName
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Spacing           -- this makes smart space around windows
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns      -- for many windows
import XMonad.Layout.ToggleLayouts     -- Full window at any time

import XMonad.Util.EZConfig            -- removeKeys, additionalKeys
import XMonad.Util.Run(spawnPipe)      -- spawnPipe, hPutStrLn
import XMonad.Util.Run

import Graphics.X11.ExtraTypes.XF86

modm = mod4Mask

colorBlue      = "#90caf9"
colorGreen     = "#a5d6a7"
colorRed       = "#ef9a9a"
colorGray      = "#9e9e9e"
colorWhite     = "#ffffff"
colorGrayAlt   = "#eceff1"
colorNormalbg  = "#212121"
colorfg        = "#9fa8b1"

main = do
    wsbar <- spawnPipe myWsBar
    xmonad $ ewmh defaultConfig
       { focusedBorderColor = "#b84130"
       , normalBorderColor  = "#02151b"
       , borderWidth = 4
       , modMask = modm
       , terminal = "urxvtc"
       , startupHook = myStartupHook
       , manageHook =  manageDocks
                       <+> myManageHook
                       <+> manageHook defaultConfig
       , layoutHook = toggleLayouts (noBorders Full) $
                      avoidStruts $
                      myShowWName $
                      myLayout
       , handleEventHook = fadeWindowsEventHook <+> docksEventHook
       , logHook = myLogHook wsbar
       }
       `additionalKeys`
       [ ((modm, xK_Return), spawn "urxvtc")
       , ((modm, xK_h), sendMessage Shrink)
       , ((modm, xK_l), sendMessage Expand)
       , ((modm, xK_Right), nextWS)
       , ((modm, xK_Left),  prevWS)
       , ((modm, xK_w),  nextScreen)
       , ((modm, xK_f), sendMessage ToggleLayout)
       , ((modm, xK_s), spawn "systemctl suspend")
       , ((0, xF86XK_MonBrightnessUp), spawn "xbacklight + 10 -time 100 -steps 5")
       , ((0, xF86XK_MonBrightnessDown), spawn "xbacklight - 10 -time 100 -steps 5")
       , ((0, xF86XK_AudioLowerVolume), spawn "amixer set Master 10%-")
       , ((0, xF86XK_AudioRaiseVolume), spawn "amixer set Master 10%+")
       , ((0, xF86XK_AudioMute),        spawn "amixer set Master toggle")
       ]

myLayout = (spacing 6 $ ResizableTall 1 (1/100) (1/2) [])
             |||  (spacing 6 $ ThreeCol 1 (1/100) (16/35))
             |||  (spacing 6 $ ResizableTall 2 (1/100) (1/2) [])

myShowWName = showWName' defaultSWNConfig
        { swn_color = colorfg
        , swn_bgcolor = colorNormalbg
        , swn_font = "xft:Verdana:pixelsize=144:antialias=true"
        , swn_fade = 0.5 }

myStartupHook = do
        setWMName "LG3D"

myManageHook = composeAll
             [ className =? "Gimp"          --> doFloat
             , className =? "VirtualBox"    --> doFloat
             , className =? "MPlayer"       --> doFloat
             , className =? "Civ5XP"        --> doFullFloat
             ]

myFadeInactiveLogHook = fadeInactiveLogHook fadeAmount
                        where fadeAmount = 0.8

myLogHook h = ewmhDesktopsLogHook <+> myFadeInactiveLogHook <+> (dynamicLogWithPP $ wsPP { ppOutput = hPutStrLn h })

myWsBar = "xmobar /home/kawasima/.xmonad/xmobarrc"

wsPP = xmobarPP { ppOrder           = \(ws:l:t:_)  -> [ws,t]
                , ppCurrent         = xmobarColor  colorGreen    colorNormalbg
                , ppUrgent          = xmobarColor  colorWhite    colorNormalbg
                , ppVisible         = xmobarColor  colorWhite    colorNormalbg
                , ppHidden          = xmobarColor  colorWhite    colorNormalbg
                , ppHiddenNoWindows = xmobarColor  colorfg       colorNormalbg
                , ppTitle           = xmobarColor  colorGreen    colorNormalbg
                , ppOutput          = putStrLn
                , ppWsSep           = ""
                , ppSep             = " : "
                }
