{-# LANGUAGE OverloadedStrings #-}

module Main where

import qualified GI.Gtk as GI (init,
                               main)
import GI.Gtk (mainQuit,
               onWidgetDestroy, containerSetBorderWidth,
               windowNew, windowSetTitle, windowSetDefaultSize, windowSetTitlebar,
               widgetShowAll, containerAdd,
               headerBarNew,headerBarSetShowCloseButton, headerBarSetTitle,
               headerBarPackEnd, headerBarPackStart,
               boxNew, buttonNew, arrowNew, textViewNew, labelNew,
               styleContextAddClass, widgetGetStyleContext,
               notebookNew, notebookAppendPage
              )
import GI.Gtk.Objects.Button
import GI.Gtk.Objects.Image
import GI.Gio.Objects.ThemedIcon
import GI.Gtk.Objects.StyleContext

import GI.Gtk.Enums
       (WindowType(..), IconSize(..), Orientation(..), ArrowType(..), ShadowType(..))


myWindow = do
  win <- windowNew WindowTypeToplevel
  windowSetTitle win "Simple Notebook Example"
  containerSetBorderWidth win 3

  notebook <- notebookNew
  containerAdd win notebook

  page1 <- boxNew OrientationHorizontal 5
  containerSetBorderWidth page1 10
  l1 <- labelNew (Just "Default Page!")
  containerAdd page1 l1
  l2 <- labelNew (Just "Plain title")
  _ <- notebookAppendPage notebook page1 (Just l2)

  page2 <- boxNew OrientationHorizontal 5
  containerSetBorderWidth page2 10
  l3 <- labelNew (Just "A page with an image for a title.")
  containerAdd page2 l3

  -- I did not exactly follow the Python example
  icon <- themedIconNew "help-about"
  image <- imageNewFromGicon icon 4
  _ <- notebookAppendPage notebook page2 (Just image)

  return win

main :: IO ()
main = do
  _ <- GI.init Nothing

  win <- myWindow
  _ <- onWidgetDestroy win mainQuit
  widgetShowAll win
  GI.main
