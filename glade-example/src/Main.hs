{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}

module Main where

import Text.RawString.QQ(r)

import Data.Maybe (fromJust)
import qualified Data.Text as T (unpack,pack)
import Data.GI.Base.ManagedPtr (unsafeCastTo)
import Data.GI.Base.GError (gerrorMessage)
import Control.Exception (catch)

import qualified GI.Gtk as GI (init,
                               main)
import GI.Gtk (mainQuit,
               builderNew,
               builderAddFromString,
               builderGetObject,
               onWidgetDestroy,
               widgetShowAll
              )

import GI.Gtk.Objects.Window
import GI.Gtk.Objects.Button

uidata :: String
uidata = [r|
<?xml version="1.0" encoding="UTF-8"?>
<interface>
  <!-- interface-requires gtk+ 3.0 -->
  <object class="GtkWindow" id="window1">
    <property name="can_focus">False</property>
    <child>
      <object class="GtkButton" id="button1">
        <property name="label" translatable="yes">button</property>
        <property name="use_action_appearance">False</property>
        <property name="visible">True</property>
        <property name="can_focus">True</property>
        <property name="receives_default">True</property>
        <property name="use_action_appearance">False</property>
      </object>
    </child>
  </object>
</interface>|]

main :: IO ()
main = do
  _ <- GI.init Nothing

  builder <- builderNew
  _ <- builderAddFromString builder (T.pack uidata) (-1)

  window1 <- builderGetObject builder "window1" >>= unsafeCastTo Window . fromJust
  button1 <- builderGetObject builder "button1" >>= unsafeCastTo Button . fromJust

  -- Basic user interaction
  _ <- onButtonClicked button1 $ putStrLn "button pressed!"
  _ <- onWidgetDestroy window1 mainQuit

  widgetShowAll window1
  GI.main
  `catch` (\(e) -> gerrorMessage e >>= putStrLn . T.unpack)
