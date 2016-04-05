module Control.Monad.Eff.OpenComputers.Address where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.OpenComputers (Component, ComponentType, Address)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..), fromMaybe)
import Data.List (List(..))

foreign import listImpl :: forall a b t. String -> Boolean -> List a -> (a -> List a -> List a) -> Eff (component :: Component | t) (List {address :: Address b, componentType :: ComponentType})

-- TODO: Doesn't work
list :: forall a t. Maybe {filter :: String, exact :: Boolean} -> Eff (component :: Component | t) (List {address :: Address a, componentType :: ComponentType})
list Nothing = listImpl "" false Nil Cons
list (Just filter) = listImpl filter.filter filter.exact Nil Cons

foreign import componentType :: forall a t. Address a -> Eff (component :: Component | t) ComponentType

foreign import fromStringImpl :: forall a t x y. (x -> Either x y) -> (y -> Either x y) -> String -> String -> Eff (component :: Component | t) (Either String (Address a))

fromString :: forall a t. String -> Maybe String -> Eff (component :: Component | t) (Either String (Address a))
fromString addr filter = fromStringImpl Left Right addr (fromMaybe "" filter)

foreign import isAvailable :: forall t. ComponentType -> Eff (component :: Component | t) Boolean
