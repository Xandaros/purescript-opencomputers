module Data.OpenComputers.Colors ( Color(..)
                                 , RGBColor(..)
                                 , LuaColor
                                 , toLuaColor
                                 , fromLuaColor
                                 , formatRGB
                                 , readRGB
                                 ) where

import Prelude

data Color = FullColor RGBColor
           | PaletteColor Int

data RGBColor = RGBColor Int Int Int

type LuaColor = {color :: Int, palette :: Boolean}

toLuaColor :: Color -> LuaColor
toLuaColor (PaletteColor c)  = {color: c, palette: true}
toLuaColor (FullColor color) = {color: formatRGB color, palette: false}

fromLuaColor :: LuaColor -> Color
fromLuaColor {color: col, palette: true}  = PaletteColor col
fromLuaColor {color: col, palette: false} = FullColor $ readRGB col

formatRGB :: RGBColor -> Int
formatRGB (RGBColor r g b) = r*256*256 + g*256 + b

readRGB :: Int -> RGBColor
readRGB col = RGBColor (col / 256 / 256) ((col / 256) `mod` 256) (col `mod` 256)

foreign import intToHex :: Int -> String
foreign import readInt :: Int -> String -> Int

instance showRGBColor :: Show RGBColor where
    show (RGBColor r g b) = "RGBColor " <> show r <> " " <> show g <> " " <> show b

instance showColor :: Show Color where
    show (PaletteColor idx) = "PaleteColor " <> show idx
    show (FullColor rgb) = "FullColor (" <> show rgb <> ")"
