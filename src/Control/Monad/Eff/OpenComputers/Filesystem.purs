module Control.Monad.Eff.OpenComputers.Filesystem where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.OpenComputers.Component (Proxy, Filesystem, Component)
import Data.Either (Either(..))
import Data.Maybe(Maybe(..))
import Data.Tuple (Tuple(..))
import Data.OpenComputers.Path (Path)

foreign import isAutorunEnabled :: forall e. Eff (filesystem :: Filesystem | e) Boolean
foreign import setAutorunEnabled :: forall e. Boolean -> Eff (filesystem :: Filesystem | e) Unit
foreign import proxy :: forall e. String -> Eff (filesystem :: Filesystem, component :: Component | e) (Proxy Filesystem)

foreign import mountImpl :: forall e a b. (a -> Either a b) -> (b -> Either a b) -> Proxy Filesystem -> Path -> Eff (filesystem :: Filesystem | e) (Either String Unit)
mount :: forall e. Proxy Filesystem -> Path -> Eff (filesystem :: Filesystem | e) (Either String Unit)
mount = mountImpl Left Right

foreign import mountsImpl :: forall e a b. (a -> b -> Tuple a b) -> Eff (filesystem :: Filesystem | e) (Array (Tuple (Proxy Filesystem) Path))
mounts :: forall e. Eff (filesystem :: Filesystem | e) (Array (Tuple (Proxy Filesystem) Path))
mounts = mountsImpl Tuple

foreign import umount :: forall e. Proxy Filesystem -> Eff (filesystem :: Filesystem | e) Boolean
foreign import umountPath :: forall e. Path -> Eff (filesystem :: Filesystem | e) Boolean
foreign import isLink :: forall e. Path -> Eff (filesystem :: Filesystem | e) Boolean

foreign import getLinkImpl :: forall e a. Maybe a -> (a -> Maybe a) -> Path -> Eff (filesystem :: Filesystem | e) (Maybe Path)
getLink :: forall e. Path -> Eff (filesystem :: Filesystem | e) (Maybe Path)
getLink = getLinkImpl Nothing Just

foreign import linkImpl :: forall e a b. (a -> Either a b) -> (b -> Either a b) -> Path -> Path -> Eff (filesystem :: Filesystem | e) (Either String Unit)
link :: forall e. Path -> Path -> Eff (filesystem :: Filesystem | e) (Either String Unit)
link = linkImpl Left Right

foreign import getImpl :: forall e a b c d. (a -> Either a b) -> (b -> Either a b) -> (c -> d -> Tuple c d) -> Path -> Eff (filesystem :: Filesystem | e) (Either String (Tuple (Proxy Filesystem) Path))
get :: forall e. Path -> Eff (filesystem :: Filesystem | e) (Either String (Tuple (Proxy Filesystem) Path))
get = getImpl Left Right Tuple

foreign import exists :: forall e. Path -> Eff (filesystem :: Filesystem | e) Boolean
foreign import size :: forall e. Path -> Eff (filesystem :: Filesystem | e) Int
foreign import isDirectory :: forall e. Path -> Eff (filesystem :: Filesystem | e) Boolean
foreign import lastModified :: forall e. Path -> Eff (filesystem :: Filesystem | e) Int

foreign import listImpl :: forall e a b. (a -> Either a b) -> (b -> Either a b) -> Path -> Eff (filesystem :: Filesystem | e) (Either String (Array String))
list :: forall e. Path -> Eff (filesystem :: Filesystem | e) (Either String (Array String))
list = listImpl Left Right

foreign import makeDirectoryImpl :: forall e a b. (a -> Either a b) -> (b -> Either a b) -> Path -> Eff (filesystem :: Filesystem | e) (Either String Unit)
makeDirectory :: forall e. Path -> Eff (filesystem :: Filesystem | e) (Either String Unit)
makeDirectory = makeDirectoryImpl Left Right

foreign import removeImpl :: forall e a b. (a -> Either a b) -> (b -> Either a b) -> Path -> Eff (filesystem :: Filesystem | e) (Either String Unit)
remove :: forall e. Path -> Eff (filesystem :: Filesystem | e) (Either String Unit)
remove = removeImpl Left Right

foreign import renameImpl :: forall e a b. (a -> Either a b) -> (b -> Either a b) -> Path -> Path -> Eff (filesystem :: Filesystem | e) (Either String Unit)
rename :: forall e. Path -> Path -> Eff (filesystem :: Filesystem | e) (Either String Unit)
rename = renameImpl Left Right

foreign import copyImpl :: forall e a b. (a -> Either a b) -> (b -> Either a b) -> Path -> Path -> Eff (filesystem :: Filesystem | e) (Either String Unit)
copy :: forall e. Path -> Path -> Eff (filesystem :: Filesystem | e) (Either String Unit)
copy = copyImpl Left Right

--open?
