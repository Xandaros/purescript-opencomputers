module Control.Monad.Eff.OpenComputers.Proxy where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.OpenComputers (Signal, Component, ComponentType, Address, Proxy)

foreign import fromAddress :: forall a t. Address a -> Eff (component :: Component | t) (Proxy a)
foreign import toAddress :: forall a t. Proxy a -> Eff (component :: Component | t) (Address a)
foreign import componentType :: forall a t. Proxy a -> Eff (component :: Component | t) ComponentType
foreign import getPrimary :: forall a t. ComponentType -> Eff (component :: Component | t) (Proxy a)
foreign import setPrimary :: forall a t. Address a -> Eff (component :: Component, signal :: Signal | t) Unit

