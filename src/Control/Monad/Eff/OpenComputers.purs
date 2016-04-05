module Control.Monad.Eff.OpenComputers where

import Prelude
import Unsafe.Coerce (unsafeCoerce)

type ComponentType = String
data Address (a :: !)
data Proxy (a :: !)

foreign import data Component :: !
foreign import data Signal :: !

instance showAddress :: Show (Address a) where
    show = unsafeCoerce
