module Control.Monad.Eff.OpenComputers.Internet
    ( URL
    , Address
    , Port
    , isAvailable
    , httpGET
    , httpPOSTRaw
    , httpPOSTFormEnc
    , tcpOpen
    ) where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.OpenComputers.Component (Component, Internet)
import Control.Monad.Eff.OpenComputers.Stream (Stream, Read, Write, Binary)
import Data.Lazy (Lazy, defer)
import Data.List.Lazy (List(..), Step(..))
import Data.Tuple(Tuple(..))

type URL = String
type Address = String
type Port = Int

foreign import isAvailable :: forall e. Eff (component :: Component | e) Boolean

foreign import httpGETImpl :: forall e a. (Lazy (Step a) -> List a) -> ((Unit -> a) -> Lazy a) -> Step a -> (a -> List a -> Step a) -> URL -> Eff (internet :: Internet | e) (List String)
httpGET :: forall e. URL -> Eff (internet :: Internet | e) (List String)
httpGET = httpGETImpl List defer Nil Cons

foreign import httpPOSTRawImpl :: forall e a. (Lazy (Step a) -> List a) -> ((Unit -> a) -> Lazy a) -> Step a -> (a -> List a -> Step a) -> String -> URL -> Eff (internet :: Internet | e) (List String)
httpPOSTRaw :: forall e. String -> URL -> Eff (internet :: Internet | e) (List String)
httpPOSTRaw = httpPOSTRawImpl List defer Nil Cons

foreign import httpPOSTFormEncImpl :: forall e a. (Lazy (Step a) -> List a) -> ((Unit -> a) -> Lazy a) -> Step a -> (a -> List a -> Step a) -> Array {first::String, second::String} -> URL -> Eff (internet :: Internet | e) (List String)
httpPOSTFormEnc :: forall e. Array (Tuple String String) -> URL -> Eff (internet :: Internet | e) (List String)
httpPOSTFormEnc = httpPOSTFormEncImpl List defer Nil Cons <<< map tupleToLua

foreign import tcpOpen :: forall e f. Address -> Port -> Eff (internet :: Internet | e) (Stream (read :: Read, write :: Write, binary :: Binary) (internet :: Internet | f))

tupleToLua :: forall a b. Tuple a b -> {first :: a, second :: b}
tupleToLua (Tuple a b) = {first:a, second:b}
