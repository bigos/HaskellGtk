{-# LANGUAGE OverloadedStrings #-}

module Main where

import Debug.Trace

import qualified GI.Gtk as GI (init,
                               main)
import GI.Gtk (buttonNew,
               boxNew,
               boxPackStart,
               checkButtonNew,
               comboBoxTextNew,
               comboBoxTextInsert,
               listBoxRowGetHeader,
               labelNew,
               labelGetLabel,
               labelGetText,
               labelSetXalign,
               listBoxNew,
               listBoxRowNew,
               listBoxInsert,
               listBoxRowGetIndex,
               containerAdd,
               containerSetBorderWidth,
               gridAttach,
               gridAttachNextTo,
               listBoxSetSelectionMode,
               mainQuit,
               onListBoxRowSelected,
               onWidgetDestroy,
               setButtonLabel,
               setWidgetValign,
               switchNew,
               widgetShowAll,
               widgetGetName,
               windowNew,
               windowSetTitle,
               gridNew)

import GI.Gtk.Enums (
  Align(..),
  Orientation(..),
  PositionType(..),
  SelectionMode(..),
  WindowType(..)
       )

main :: IO ()
main = do
  _ <- GI.init Nothing

  win <- windowNew WindowTypeToplevel
  windowSetTitle win "ListBox Demo"
  containerSetBorderWidth win 10

  boxOuter <- boxNew OrientationVertical 6
  containerAdd win boxOuter

  listBox <- listBoxNew
  listBoxSetSelectionMode listBox SelectionModeNone
  boxPackStart boxOuter listBox True True 0

  row <- listBoxRowNew
  hbox <- boxNew OrientationHorizontal 50
  containerAdd row hbox
  vbox <-boxNew OrientationVertical 0
  boxPackStart hbox vbox True True 0

  label1 <- labelNew (Just "Automatic Date & Time")
  labelSetXalign label1 0
  label2 <- labelNew (Just "Requires internet access")
  labelSetXalign label2 0
  boxPackStart vbox label1 True True 0
  boxPackStart vbox label2 True True 0

  switch <- switchNew
  setWidgetValign switch AlignCenter
  boxPackStart hbox switch False True 0

  containerAdd listBox row

  row <- listBoxRowNew
  hbox <- boxNew OrientationHorizontal 50
  containerAdd row hbox
  label <- labelNew (Just "Enable Automatic Update")
  labelSetXalign label 0
  check <- checkButtonNew
  boxPackStart hbox label True True 0
  boxPackStart hbox check False True 0

  containerAdd listBox row

  row <- listBoxRowNew
  hbox <- boxNew OrientationHorizontal 50
  containerAdd row hbox
  label <- labelNew (Just "Date Format")
  labelSetXalign label 0
  combo <- comboBoxTextNew
  comboBoxTextInsert combo 0 (Just"0") "24-hour"
  comboBoxTextInsert combo 1 (Just "1") "AM/PM"
  boxPackStart hbox label True True 0
  boxPackStart hbox combo False True 0

  containerAdd listBox row

  listbox2 <- listBoxNew
  --items <- ["This"," is"," a"," sorted"," ListBox"," Fail"]
  lb <- listBoxRowNew
  dat <- labelNew (Just "This")
  containerAdd lb dat
  listBoxInsert listbox2 lb (-1)

  lb <- listBoxRowNew
  dat <- labelNew (Just "is")
  containerAdd lb dat
  listBoxInsert listbox2 lb (-1)

  lb <- listBoxRowNew
  dat <- labelNew (Just "a")
  containerAdd lb dat
  listBoxInsert listbox2 lb (-1)

  lb <- listBoxRowNew
  dat <- labelNew (Just "sorted")
  containerAdd lb dat
  listBoxInsert listbox2 lb (-1)

  lb <- listBoxRowNew
  dat <- labelNew (Just "ListBox")
  containerAdd lb dat
  listBoxInsert listbox2 lb (-1)

  lb <- listBoxRowNew
  dat <- labelNew (Just "Fail")
  containerAdd lb dat
  listBoxInsert listbox2 lb (-1)

  -- how do I solve this silly type error???
  onListBoxRowSelected listbox2 (\(Just row) -> listBoxRowGetIndex row >>= print)


  boxPackStart boxOuter listbox2 True True 0
  widgetShowAll listbox2

  _ <- onWidgetDestroy win mainQuit
  widgetShowAll win
  GI.main
