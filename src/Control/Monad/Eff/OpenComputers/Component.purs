module Control.Monad.Eff.OpenComputers.Component where

import Prelude
import Unsafe.Coerce (unsafeCoerce)

foreign import data Printer3D :: !
--foreign import data AbstractBus :: !
foreign import data AccessPoint :: !
foreign import data Chunkloader :: !
foreign import data Computer :: !
foreign import data Crafting :: !
foreign import data Data :: !
foreign import data Database :: !
foreign import data Debug :: !
foreign import data Drone :: !
foreign import data Drive :: !
foreign import data EEPROM :: !
foreign import data Experience :: !
foreign import data Filesystem :: !
foreign import data Generator :: !
foreign import data Geolyzer :: !
foreign import data GPU :: !
foreign import data Hologram :: !
foreign import data Internet :: !
--foreign import data InventoryController :: !
--foreign import data RobotInventory :: !
foreign import data Keyboard :: !
foreign import data Leash :: !
foreign import data Modem :: !
foreign import data MotionSensor :: !
foreign import data Navigation :: !
foreign import data Permission :: !
foreign import data Piston :: !
foreign import data Redstone :: !
foreign import data Robot :: !
foreign import data Screen :: !
foreign import data Sign :: !
foreign import data TankController :: !
foreign import data TractorBeam :: !
foreign import data Tunnel :: !
--foreign import data WorldSensor :: !
foreign import data Window :: !

type ComponentType = String
data Address (a :: !)
data Proxy (a :: !)

foreign import data Component :: !
foreign import data Signal :: !

instance showAddress :: Show (Address a) where
    show = unsafeCoerce
