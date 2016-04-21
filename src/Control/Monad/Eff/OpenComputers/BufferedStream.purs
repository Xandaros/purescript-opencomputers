module Control.Monad.Eff.OpenComputers.BufferedStream
    ( BufferedStream
    , BufferedReadable
    , BufferedWritable
    , BufferMode(..)
    , fromStream
    , close
    , flush
    , read
    , readLine
    , readAll
    , seek
    , setBufferMode
    , getBufferSize
    , write
    ) where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.OpenComputers.Stream (Stream, Whence, Read, Write, Seek)
import Data.Either (Either(..))

foreign import data BufferedStream :: # * -> # ! -> *

type BufferedReadable e = BufferedStream (read :: Read | e)
type BufferedWritable e = BufferedStream (write :: Write | e)

data BufferMode = NoBuffering
                | FullBuffering
                | LineBuffering

type Left a b = a -> Either a b
type Right a b = b -> Either a b

foreign import fromStream :: forall r e. Stream r e -> BufferedStream r e
foreign import close :: forall r e. BufferedStream r e -> Eff e Unit

foreign import flushImpl :: forall r e a b. Left a b -> Right a b -> BufferedStream r e -> Eff e (Either String Unit)
flush :: forall r e. BufferedStream r e -> Eff e (Either String Unit)
flush = flushImpl Left Right

--lines :: ITERATOR BULLSHIT!!!!!

foreign import readImpl :: forall r e a b. Left a b -> Right a b -> BufferedReadable r e -> Int -> Eff e (Either String String)
read :: forall r e. BufferedReadable r e -> Int -> Eff e (Either String String)
read = readImpl Left Right

foreign import readLineImpl :: forall r e a b. Left a b -> Right a b -> BufferedReadable r e -> Eff e (Either String String)
readLine :: forall r e. BufferedReadable r e -> Eff e (Either String String)
readLine = readLineImpl Left Right

foreign import readAllImpl :: forall r e a b. Left a b -> Right a b -> BufferedReadable r e -> Eff e (Either String String)
readAll :: forall r e. BufferedReadable r e -> Eff e (Either String String)
readAll = readAllImpl Left Right

foreign import seekImpl :: forall r e a b. Left a b -> Right a b -> BufferedStream (seek :: Seek | r) e -> String -> Int -> Eff e (Either String Int)
seek :: forall r e. BufferedStream (seek :: Seek | r) e -> Whence -> Int -> Eff e (Either String Int)
seek s = seekImpl Left Right s <<< show

foreign import setBufferModeImpl :: forall r e. BufferedStream r e -> String -> Eff e Unit
setBufferMode :: forall r e. BufferedStream r e -> BufferMode -> Eff e Unit
setBufferMode s = setBufferModeImpl s <<< bufferModeToLua

foreign import getBufferModeImpl :: forall r e. BufferedStream r e -> Eff e String
getBufferMode :: forall r e. BufferedStream r e -> Eff e BufferMode
getBufferMode = map luaToBufferMode <<< getBufferModeImpl

foreign import setBufferSize :: forall r e. BufferedStream r e -> Int -> Eff e Unit
foreign import getBufferSize :: forall r e. BufferedStream r e -> Eff e Int

foreign import writeImpl :: forall r e a b. Left a b -> Right a b -> BufferedWritable r e -> String -> Eff e (Either String Unit)
write :: forall r e. BufferedWritable r e -> String -> Eff e (Either String Unit)
write = writeImpl Left Right

bufferModeToLua :: BufferMode -> String
bufferModeToLua NoBuffering = "no"
bufferModeToLua FullBuffering = "full"
bufferModeToLua LineBuffering = "line"

luaToBufferMode :: String -> BufferMode
luaToBufferMode "no" = NoBuffering
luaToBufferMode "full" = FullBuffering
luaToBufferMode "line" = LineBuffering
luaToBufferMode _ = error "Unknown buffer mode"

foreign import error :: forall a. String -> a
