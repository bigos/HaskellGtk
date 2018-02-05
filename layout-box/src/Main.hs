  {-# LANGUAGE OverloadedStrings #-}

  module Main where

  import qualified GI.Gtk as GI (init,
                                 main)
  import GI.Gtk (buttonNew,
                 boxNew,
                 containerAdd,
                 boxPackStart,
                 mainQuit,
                 onButtonClicked,
                 onWidgetDestroy,
                 setButtonLabel,
                 windowNew,
                 windowSetTitle,
                 widgetShowAll)
  import GI.Gtk.Enums
         (WindowType(..), Orientation(..))

  main :: IO ()
  main = do
    _ <- GI.init Nothing

    win <- windowNew WindowTypeToplevel
    windowSetTitle win "Hello World"

    box <- boxNew OrientationHorizontal 10

    btn1 <- buttonNew
    setButtonLabel btn1 "Hello"
    _ <- onButtonClicked btn1 (putStrLn "Hello")
    boxPackStart box btn1 True True 0

    btn2 <- buttonNew
    setButtonLabel btn2 "Goodbye"
    _ <- onButtonClicked btn2 (putStrLn "Goodbye")
    boxPackStart box btn2 True True 0

    containerAdd win box

    _ <- onWidgetDestroy win mainQuit
    widgetShowAll win
    GI.main
