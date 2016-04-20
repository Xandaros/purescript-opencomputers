module Control.Monad.Eff.OpenComputers.Internet
    ( URL
    , isAvailable
    , httpGET
    , httpPOSTRaw
    , httpPOSTFormEnc
    ) where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.OpenComputers.Component (Component, Internet)
import Data.Lazy (Lazy, defer)
import Data.List.Lazy (List(..), Step(..))
import Data.Tuple(Tuple(..))

type URL = String

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

--tcpOpen :: forall e. Address -> Port -> Eff (internet :: Internet | e) Handle
--tcpOpenBuffered :: forall e. Address -> Port -> Eff (internet :: Internet | e) BufferedHandle

tupleToLua :: forall a b. Tuple a b -> {first :: a, second :: b}
tupleToLua (Tuple a b) = {first:a, second:b}
