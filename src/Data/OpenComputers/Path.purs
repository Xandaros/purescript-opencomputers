module Data.OpenComputers.Path where

import Prelude
import Data.Monoid (Monoid)

newtype Path = Path String

fromString :: String -> Path
fromString = Path

foreign import canonicalPath :: Path -> Path
foreign import segments :: Path -> Array String
foreign import concat :: Array Path -> Path
foreign import path :: Path -> Path
foreign import name :: Path -> String

instance showPath :: Show Path where
    show (Path p) = p

instance semigroupPath :: Semigroup Path where
    append p q = concat [p, q]

instance monoidPath :: Monoid Path where
    mempty = fromString ""
