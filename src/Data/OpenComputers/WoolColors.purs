module Data.OpenComputers.WoolColors where
import Prelude
import Data.Enum (class Enum, class BoundedEnum, Cardinality(Cardinality), fromEnum)
import Data.Maybe (Maybe(Nothing, Just))

data WoolColor = White
               | Orange
               | Magenta
               | Lightblue
               | Yellow
               | Lime
               | Pink
               | Gray
               | Silver
               | Cyan
               | Purple
               | Blue
               | Brown
               | Green
               | Red
               | Black

instance boundedColor :: Bounded WoolColor where
    bottom = White
    top = Black

instance enumColor :: Enum WoolColor where
    succ White     = Just Orange   
    succ Orange    = Just Magenta  
    succ Magenta   = Just Lightblue
    succ Lightblue = Just Yellow   
    succ Yellow    = Just Lime     
    succ Lime      = Just Pink     
    succ Pink      = Just Gray     
    succ Gray      = Just Silver   
    succ Silver    = Just Cyan     
    succ Cyan      = Just Purple   
    succ Purple    = Just Blue     
    succ Blue      = Just Brown    
    succ Brown     = Just Green    
    succ Green     = Just Red      
    succ Red       = Just Black    
    succ Black     = Nothing

    pred White     = Nothing
    pred Orange    = Just White
    pred Magenta   = Just Orange
    pred Lightblue = Just Magenta
    pred Yellow    = Just Lightblue
    pred Lime      = Just Yellow
    pred Pink      = Just Lime
    pred Gray      = Just Pink
    pred Silver    = Just Gray
    pred Cyan      = Just Silver
    pred Purple    = Just Cyan
    pred Blue      = Just Purple
    pred Brown     = Just Blue
    pred Green     = Just Brown
    pred Red       = Just Green
    pred Black     = Just Red

instance boundedEnumColor :: BoundedEnum WoolColor where
    toEnum 0       = Just White
    toEnum 1       = Just Orange
    toEnum 2       = Just Magenta
    toEnum 3       = Just Lightblue
    toEnum 4       = Just Yellow
    toEnum 5       = Just Lime
    toEnum 6       = Just Pink
    toEnum 7       = Just Gray
    toEnum 8       = Just Silver
    toEnum 9       = Just Cyan
    toEnum 10      = Just Purple
    toEnum 11      = Just Blue
    toEnum 12      = Just Brown
    toEnum 13      = Just Green
    toEnum 14      = Just Red
    toEnum 15      = Just Black
    toEnum _       = Nothing

    fromEnum White     = 0
    fromEnum Orange    = 1
    fromEnum Magenta   = 2
    fromEnum Lightblue = 3
    fromEnum Yellow    = 4
    fromEnum Lime      = 5
    fromEnum Pink      = 6
    fromEnum Gray      = 7
    fromEnum Silver    = 8
    fromEnum Cyan      = 9
    fromEnum Purple    = 10
    fromEnum Blue      = 11
    fromEnum Brown     = 12
    fromEnum Green     = 13
    fromEnum Red       = 14
    fromEnum Black     = 15

    cardinality = Cardinality 16

instance eqColor :: Eq WoolColor where
    eq a b = (fromEnum a) == (fromEnum b)

instance ordColor :: Ord WoolColor where
	compare a b = compare (fromEnum a) (fromEnum b)
