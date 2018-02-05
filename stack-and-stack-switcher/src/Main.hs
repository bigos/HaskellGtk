{-# LANGUAGE OverloadedStrings #-}

module Main where

import qualified GI.Gtk as GI (init,
                                 main)
import GI.Gtk (boxNew,
               boxPackStart,
               checkButtonNewWithLabel,
               containerAdd,
               labelNew,
               labelSetMarkup,
               mainQuit,
               onWidgetDestroy,
               stackAddTitled,
               stackNew,
               stackSetTransitionDuration,
               stackSetTransitionType,
               stackSwitcherNew,
               stackSwitcherSetStack,
               widgetShowAll,
               windowNew,
               windowSetTitle)

import GI.Gtk.Enums (WindowType(..),
                     Orientation(..),
                     StackTransitionType(..))

main :: IO ()
main = do
  _ <- GI.init Nothing

  win <- windowNew WindowTypeToplevel
  windowSetTitle win "Stack Demo"

  vbox <- boxNew OrientationVertical 6
  containerAdd win vbox

  stack <- stackNew
  stackSetTransitionType stack StackTransitionTypeSlideLeftRight
  stackSetTransitionDuration stack 1000

  checkbutton <- checkButtonNewWithLabel "Click me!"
  stackAddTitled stack checkbutton "check" "Check Button!"

  label <- labelNew (Just "")
  labelSetMarkup label "<big>A fancy label</big>"
  stackAddTitled stack label "label" "A label"

  stackSwitcher <- stackSwitcherNew
  stackSwitcherSetStack stackSwitcher (Just stack)
  boxPackStart vbox stackSwitcher True True 0
  boxPackStart vbox stack True True 0

  _ <- onWidgetDestroy win mainQuit
  widgetShowAll win
  GI.main
