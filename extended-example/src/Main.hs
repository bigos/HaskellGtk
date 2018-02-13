{-# LANGUAGE OverloadedStrings #-}

module Main where

import qualified GI.Gtk as GI (init,
                               main)
import GI.Gtk (buttonNew,
               containerAdd,
               mainQuit,
               onButtonClicked,
               onWidgetDestroy,
               setButtonLabel,
               windowNew,
               windowSetTitle,
               widgetShowAll)
import GI.Gtk.Enums
       (WindowType(..))

main :: IO ()
main = do
  _ <- GI.init Nothing

  win <- windowNew WindowTypeToplevel
  windowSetTitle win "Hello World"
  _ <- onWidgetDestroy win mainQuit

  btn <- buttonNew
  setButtonLabel btn "Click here"
  _ <- onButtonClicked btn (putStrLn "Button clicked")

  containerAdd win btn
  widgetShowAll win
  GI.main
