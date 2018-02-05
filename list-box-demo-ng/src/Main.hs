{-# LANGUAGE OverloadedStrings #-}
module Main where

import Data.Text (unpack)
import Data.Text.Internal

import qualified GI.Gtk as GI (init,
                               main)
import GI.Gtk hiding (init, main)

-- (boxNew,
--                binGetChild,
--                boxPackStart,
--                checkButtonNew,
--                comboBoxTextInsert,
--                comboBoxTextNew,
--                containerAdd,
--                containerGetChildren,
--                containerSetBorderWidth,
--                labelNew,
--                labelSetXalign,
--                labelGetLabel,
--                labelGetText,
--                widgetGetName,
--                listBoxInsert,
--                listBoxNew,
--                listBoxRowGetIndex,
--                listBoxRowGetSelectable,
--                listBoxRowNew,
--                listBoxSetSelectionMode,
--                mainQuit,
--                onListBoxRowSelected,
--                onWidgetDestroy,
--                setWidgetValign,
--                switchNew,
--                widgetShowAll,
--                windowNew,
--                windowSetTitle)

import GI.Gtk.Enums (Align(..),
                     Orientation(..),
                     SelectionMode(..),
                     WindowType(..))

listBoxAddLabel lb txt = do
  lbr <- listBoxRowNew
  dat <- labelNew (Just txt)
  containerAdd lbr dat
  listBoxInsert lb lbr (-1)

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

  mapM_ (\x  -> listBoxAddLabel listbox2 x ) ["This","is","a","ListBox"]

  -- how do I print the strings assigned to the list box options
  _ <- onListBoxRowSelected listbox2 (\(Just r) -> do
                                         cc <- containerGetChildren r
                                         mlabel <- castTo Label (head cc)
                                         case mlabel of
                                           Nothing -> putStrLn "Not a label!"
                                           Just label -> (labelGetText label) >>= putStrLn . unpack)


  boxPackStart boxOuter listbox2 True True 0

  _ <- onWidgetDestroy win mainQuit
  widgetShowAll win
  GI.main
