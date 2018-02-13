{-# LANGUAGE OverloadedStrings #-}

module Main where

import qualified GI.Gtk as GI (init,
                               main)
import GI.Gtk (buttonNew,
               boxNew,
               containerAdd,
               boxPackStart,
               boxSetHomogeneous,
               labelNew,
               labelNewWithMnemonic,
               labelSetMarkup,
               labelSetMnemonicWidget,
               labelSetText,
               labelSetJustify,
               labelSetSelectable,
               labelSetLineWrap,
               mainQuit,
               onButtonClicked,
               onWidgetDestroy,
               setButtonLabel,
               windowNew,
               windowSetTitle,
               widgetShowAll)

import Data.Text (pack, unpack)

import GI.Gtk.Enums
       (WindowType(..), Orientation(..), Justification(..))

main :: IO ()
main = do
  _ <- GI.init Nothing

  win <- windowNew WindowTypeToplevel
  windowSetTitle win "Label Example"

  hbox <- boxNew OrientationHorizontal 10
  boxSetHomogeneous hbox False
  vboxLeft <- boxNew OrientationVertical 10
  boxSetHomogeneous vboxLeft False
  vboxRight <- boxNew OrientationVertical 10
  boxSetHomogeneous vboxRight False

  boxPackStart hbox vboxLeft  True True 0
  boxPackStart hbox vboxRight True True 0

  label1 <- labelNew (Just "This is a normal label")
  boxPackStart vboxLeft label1 True True 0

  label2 <- labelNew Nothing
  labelSetText label2 "This is a left-justified label.\nWith multiple lines."
  labelSetJustify label2 JustificationLeft
  boxPackStart vboxLeft label2 True True 0

  label3 <- labelNew Nothing
  labelSetText label3 "This is a right-justified label.\nWith multiple lines."
  labelSetJustify label3 JustificationRight
  boxPackStart vboxLeft label3 True True 0

  label4 <- labelNew (Just
                       (pack
                         (foldl (\a x -> a ++ x) ""
                           [ "This is an example of a line-wrapped label.  It "
                           , "should not be taking up the entire             "
                           , "width allocated to it, but automatically "
                           , "wraps the words to fit.\n"
                           , "     It supports multiple paragraphs correctly, "
                           , "and  correctly   adds "
                           , "many          extra  spaces."])))
  labelSetLineWrap label4 True
  boxPackStart vboxRight label4 True True 0

  label5 <- labelNew (Just
                      (pack
                       (foldl (\a x -> a ++ x) ""
                         ["This is an example of a line-wrapped, filled label. "
                         , "It should be taking "
                         , "up the entire              width allocated to it.  "
                         , "Here is a sentence to prove "
                         , "my point.  Here is another sentence. "
                         , "Here comes the sun, do de do de do.\n"
                         , "    This is a new paragraph.\n"
                         , "    This is another newer, longer, better "
                         , "paragraph.  It is coming to an end, "
                         , "unfortunately."])))
  labelSetLineWrap label5 True
  labelSetJustify label5 JustificationFill
  boxPackStart vboxRight label5 True True 0

  label6 <- labelNew Nothing
  labelSetMarkup label6 (pack
                          (foldl (\a x -> a ++ x) ""
                           [ "Text can be <small>small</small>, <big>big</big>, "
                           , "<b>bold</b>, <i>italic</i> and even point to "
                           , "somewhere in the <a href=\"http://www.gtk.org\" "
                           , "title=\"Click to find out more\">internets</a>." ]))
  labelSetLineWrap label6 True
  boxPackStart vboxLeft label6 True True 0

  label7 <- labelNewWithMnemonic (Just "_Press Alt + P to select button to the right")
  boxPackStart vboxLeft label7 True True 0
  labelSetSelectable label7 True

  button <- buttonNew
  setButtonLabel button "Click at your own risk"
  labelSetMnemonicWidget label7 (Just button)
  boxPackStart vboxRight button True True 0

  containerAdd win hbox

  _ <- onWidgetDestroy win mainQuit
  widgetShowAll win
  GI.main
