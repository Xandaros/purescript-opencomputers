module Control.Monad.Eff.OpenComputers.Stream
    ( Stream
    , Whence(..)
    , read
    , write
    , close
    , seek
    ) where

import Prelude
import Control.Monad.Eff (Eff)
import Data.Either (Either(..))

data Stream (e :: # !)

data Whence = Set
            | Cur
            | End

foreign import readImpl :: forall e a b. (a -> Either a b) -> (b -> Either a b) -> Stream e -> Int -> Eff e (Either String String)
read :: forall e. Stream e -> Int -> Eff e (Either String String)
read = readImpl Left Right

foreign import writeImpl :: forall e a b. (a -> Either a b) -> (b -> Either a b) -> Stream e -> String -> Eff e (Either String Unit)
write :: forall e. Stream e -> String -> Eff e (Either String Unit)
write = writeImpl Left Right

foreign import close :: forall e. Stream e -> Eff e Unit

foreign import seekImpl :: forall e a b. (a -> Either a b) -> (b -> Either a b) -> Stream e -> String -> Int -> Eff e (Either String Int)
seek :: forall e. Stream e -> Whence -> Int -> Eff e (Either String Int)
seek stream = seekImpl Left Right stream <<< whenceToLua

whenceToLua :: Whence -> String
whenceToLua Set = "set"
whenceToLua Cur = "cur"
whenceToLua End = "end"
