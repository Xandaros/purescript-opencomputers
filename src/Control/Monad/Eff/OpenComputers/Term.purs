module Control.Monad.Eff.OpenComputers.Term where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.OpenComputers.Component (Component, Proxy, Window, Screen, Keyboard, GPU)
import Control.Monad.Eff.OpenComputers.Stream (Binary)
import Control.Monad.Eff.OpenComputers.BufferedStream (BufferedReadable, BufferedWritable)
import Data.List (List)

type Viewport = { width :: Int
                , height :: Int
                , xOffset :: Int
                , yOffset :: Int
                , relX :: Int
                , relY :: Int
                }

type Point = {x :: Int, y :: Int}

foreign import isAvailable :: forall e. Eff (component :: Component | e) Boolean
foreign import getViewport :: forall e. Eff (window :: Window | e) Viewport
foreign import getGPU :: forall e. Eff (component :: Component | e) (Proxy GPU)
foreign import getCursor :: forall e. Eff (window :: Window | e) Point
foreign import setCursor :: forall e. Int -> Int -> Eff (window :: Window | e) Unit
foreign import isBlinking :: forall e. Eff (window :: Window | e) Boolean
foreign import setBlinking :: forall e. Boolean -> Eff (window :: Window | e) Unit
foreign import clear :: forall e. Eff (window :: Window, screen :: Screen | e) Unit
foreign import clearLine :: forall e. Eff (window :: Window, screen :: Screen | e) Unit
foreign import read :: forall e. Boolean -> Boolean -> (String -> Int -> List String) -> List String -> Char -> Eff (window :: Window, screen :: Screen, keyboard :: Keyboard | e) String
foreign import write :: forall e. Boolean -> String -> Eff (window :: Window, screen :: Screen | e) Unit
--readKeyboard :: forall e.
--drawText :: forall e. Boolean -> String -> Eff (window ::)
foreign import screen :: forall e. Eff (window :: Window, component :: Component | e) (Proxy Screen)
foreign import keyboard :: forall e. Eff (window :: Window, component :: Component | e) (Proxy Keyboard)
foreign import stdin :: forall e f. Eff (window :: Window | e) (BufferedReadable (binary :: Binary) (screen :: Screen, keyboard :: Keyboard | f))
foreign import stdout :: forall e f. Eff (window :: Window | e) (BufferedWritable (binary :: Binary) (screen :: Screen, keyboard :: Keyboard | f))
foreign import stderr :: forall e f. Eff (window :: Window | e) (BufferedWritable (binary :: Binary) (screen :: Screen, keyboard :: Keyboard | f))
