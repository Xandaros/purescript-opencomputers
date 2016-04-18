module Control.Monad.Eff.OpenComputers.Component.GPU
  ( getPrimary
  , bind
  , getScreen
  , getBackgroundColor
  , setBackgroundColor
  , getForegroundColor
  , setForegroundColor
  , getPaletteColor
  , setPaletteColor
  , maxDepth
  , getDepth
  , setDepth
  , maxResolution
  , getResolution
  , setResolution
  , get
  , write
  , copy
  , fill
  , Resolution
  ) where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.OpenComputers.Component (Component, Address, Proxy, GPU, Screen)
import Control.Monad.Eff.OpenComputers.Proxy as Proxy
import Data.Either (Either(..))
import Data.OpenComputers.Colors (Color, RGBColor, LuaColor, toLuaColor, fromLuaColor, formatRGB, readRGB)
import Unsafe.Coerce (unsafeCoerce)

type Resolution = { width :: Int, height :: Int }

getPrimary :: forall e. Eff (component :: Component | e) (Proxy GPU)
getPrimary = unsafeCoerce <$> Proxy.getPrimary "gpu"

-------------------------------------------

foreign import bindImpl :: forall e a b. (a -> Either a b) -> (b -> Either a b) -> Proxy GPU -> Address Screen -> Eff (component :: Component | e) (Either String Unit)
bind :: forall e. Proxy GPU -> Address Screen -> Eff (component :: Component | e) (Either String Unit)
bind = bindImpl Left Right

foreign import getScreen :: forall e. Proxy GPU -> Eff (component :: Component | e) (Address Screen)

foreign import getBackgroundColorImpl :: forall e. Proxy GPU -> Eff (screen :: Screen | e) LuaColor
getBackgroundColor :: forall e. Proxy GPU -> Eff (screen :: Screen | e) Color
getBackgroundColor gpu = fromLuaColor <$> getBackgroundColorImpl gpu

foreign import setBackgroundColorImpl :: forall e. Proxy GPU -> LuaColor -> Eff (screen :: Screen | e) Unit
setBackgroundColor :: forall e. Proxy GPU -> Color -> Eff (screen :: Screen | e) Unit
setBackgroundColor gpu = setBackgroundColorImpl gpu <<< toLuaColor

foreign import getForegroundColorImpl :: forall e. Proxy GPU -> Eff (screen :: Screen | e) LuaColor
getForegroundColor :: forall e. Proxy GPU -> Eff (screen :: Screen | e) Color
getForegroundColor gpu = fromLuaColor <$> getForegroundColorImpl gpu

foreign import setForegroundColorImpl :: forall e. Proxy GPU -> LuaColor -> Eff (screen :: Screen | e) Unit
setForegroundColor :: forall e. Proxy GPU -> Color -> Eff (screen :: Screen | e) Unit
setForegroundColor gpu = setForegroundColorImpl gpu <<< toLuaColor

foreign import getPaletteColorImpl :: forall e. Proxy GPU -> Int -> Eff (screen :: Screen | e) Int
getPaletteColor :: forall e. Proxy GPU -> Int -> Eff (screen :: Screen | e) RGBColor
getPaletteColor gpu = map readRGB <<< getPaletteColorImpl gpu

foreign import setPaletteColorImpl :: forall e. Proxy GPU -> Int -> Int -> Eff (screen :: Screen | e) Unit
setPaletteColor :: forall e. Proxy GPU -> Int -> RGBColor -> Eff (screen :: Screen | e) Unit
setPaletteColor gpu idx col = setPaletteColorImpl gpu idx (formatRGB col)

foreign import maxDepth :: forall e. Proxy GPU -> Eff (screen :: Screen, gpu :: GPU | e) Int

foreign import getDepth :: forall e. Proxy GPU -> Eff (screen :: Screen, gpu :: GPU | e) Int

foreign import setDepth :: forall e. Proxy GPU -> Int -> Eff (gpu :: GPU | e) Boolean

foreign import maxResolution :: forall e. Proxy GPU -> Eff (gpu :: GPU, screen :: Screen | e) Resolution

foreign import getResolution :: forall e. Proxy GPU -> Eff (gpu :: GPU | e) Resolution

foreign import setResolution :: forall e. Proxy GPU -> Resolution -> Eff (gpu :: GPU | e) Boolean

foreign import getImpl :: forall e. Proxy GPU -> Int -> Int -> Eff (screen :: Screen | e) {char :: Char, backgroundColor :: LuaColor, foregroundColor :: LuaColor}
get :: forall e. Proxy GPU -> Int -> Int -> Eff (screen :: Screen | e) {char :: Char, backgroundColor :: Color, foregroundColor :: Color}
get gpu x y = getImpl gpu x y >>= \ret -> -- TODO: Convert back to do-notation (bug in PS)
                 pure {char:ret.char, backgroundColor:fromLuaColor ret.backgroundColor, foregroundColor:fromLuaColor ret.foregroundColor}

foreign import write :: forall e. Proxy GPU -> Boolean -> Int -> Int -> String -> Eff (screen :: Screen | e) Boolean

foreign import copy :: forall e. Proxy GPU -> Int -> Int -> Int -> Int -> Int -> Int -> Eff (screen :: Screen | e) Boolean

foreign import fill :: forall e. Proxy GPU -> Int -> Int -> Int -> Int -> Char -> Eff (screen :: Screen | e) Boolean
