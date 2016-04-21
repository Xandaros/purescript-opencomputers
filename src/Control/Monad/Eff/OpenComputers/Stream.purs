module Control.Monad.Eff.OpenComputers.Stream
    ( Stream
    , Whence(..)
    , Read
    , Write
    , Binary
    , Seek
    , Readable
    , Writable
    , read
    , write
    , close
    , seek
    ) where

import Prelude
import Control.Monad.Eff (Eff)
import Data.Either (Either(..))

foreign import data Stream :: # * -> # ! -> *

type Readable r = Stream (read :: Read | r)
type Writable r = Stream (write :: Write | r)

data Read
data Write
data Binary
data Seek

data Whence = Set
            | Cur
            | End

foreign import readImpl :: forall r e a b. (a -> Either a b) -> (b -> Either a b) -> Readable r e -> Int -> Eff e (Either String String)
read :: forall r e. Readable r e -> Int -> Eff e (Either String String)
read = readImpl Left Right

foreign import writeImpl :: forall r e a b. (a -> Either a b) -> (b -> Either a b) -> Writable r e -> String -> Eff e (Either String Unit)
write :: forall r e. Writable r e -> String -> Eff e (Either String Unit)
write = writeImpl Left Right

foreign import close :: forall r e. Stream r e -> Eff e Unit

foreign import seekImpl :: forall r e a b. (a -> Either a b) -> (b -> Either a b) -> Stream (seek :: Seek | r) e -> String -> Int -> Eff e (Either String Int)
seek :: forall r e. Stream (seek :: Seek | r) e -> Whence -> Int -> Eff e (Either String Int)
seek stream = seekImpl Left Right stream <<< whenceToLua

whenceToLua :: Whence -> String
whenceToLua Set = "set"
whenceToLua Cur = "cur"
whenceToLua End = "end"
