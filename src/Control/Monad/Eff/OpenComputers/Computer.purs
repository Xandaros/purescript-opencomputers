module Control.Monad.Eff.OpenComputers.Computer
  ( Player
  , address
  , tmpAddress
  , freeMemory
  , totalMemory
  , energy
  , maxEnergy
  , isRobot
  , uptime
  , shutdown
  , reboot
  , bootAddress
  , setBootAddress
  , runlevel
  , users
  , addUser
  , removeUser
  ) where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.OpenComputers.Component (Component, Address, Computer, Filesystem, Permission)
import Data.Either(Either(..))
import Data.Maybe(Maybe)
import Data.List(List)

type Player = String

foreign import address :: forall e. Eff (component :: Component | e) (Address Computer)
foreign import tmpAddress :: forall e. Eff (component :: Component | e) (Address Filesystem)
foreign import freeMemory :: forall e. Eff (computer :: Computer | e) Int
foreign import totalMemory :: forall e. Eff (computer :: Computer | e) Int
foreign import energy :: forall e. Eff (computer :: Computer | e) Number
foreign import maxEnergy :: forall e. Eff (computer :: Computer | e) Number
foreign import isRobot :: forall e. Eff (computer :: Computer, component :: Component | e) Boolean
foreign import uptime :: forall e. Eff (computer :: Computer | e) Number
foreign import shutdown :: forall e. Eff (computer :: Computer | e) Void
foreign import reboot :: forall e. Eff (computer :: Computer | e) Void
foreign import bootAddress :: forall e. Eff (computer :: Computer | e) (Address Filesystem)
foreign import setBootAddress :: forall e. (Maybe (Address Filesystem)) -> Eff (computer :: Computer | e) Unit
--


foreign import runlevelImpl :: forall e a b. (a -> Either a b) -> (b -> Either a b) -> Eff (computer :: Computer | e) (Either String Int)
runlevel :: forall e. Eff (computer :: Computer | e) (Either String Int)
runlevel = runlevelImpl Left Right

foreign import users :: forall e. Eff (permission :: Permission | e) (List Player)

foreign import addUserImpl :: forall e a b. (a -> Either a b) -> (b -> Either a b) -> Player -> Eff (permission :: Permission | e) (Either String Unit)
addUser :: forall e. Player -> Eff (permission :: Permission | e) (Either String Unit)
addUser = addUserImpl Left Right

foreign import removeUser :: forall e. Player -> Eff (permission :: Permission | e) Boolean
