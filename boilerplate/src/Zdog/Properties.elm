module Zdog.Properties exposing
    ( Property(..)
    , width, height, translate, rotate, scale, diameter, length_
    , radius, cornerRadius, sides
    , color, stroke, fill, closed, enableStroke
    , leftFace, rightFace, topFace, bottomFace, frontFace, backface
    )

import Json.Encode as Encode exposing (Value)
import Zdog.Vector as Vector exposing (Vector)


type Property
    = Property String Value


width : Int -> Property
width =
    fromEncoder "width" Encode.int


height : Int -> Property
height =
    fromEncoder "height" Encode.int


diameter : Int -> Property
diameter =
    fromEncoder "diameter" Encode.int


length_ : Int -> Property
length_ =
    fromEncoder "length" Encode.int


translate : Vector -> Property
translate =
    vector "translate"


rotate : Vector -> Property
rotate =
    vector "rotate"


scale : Vector -> Property
scale =
    vector "scale"


color : String -> Property
color =
    fromEncoder "color" Encode.string


leftFace : String -> Property
leftFace =
    fromEncoder "leftFace" Encode.string


rightFace : String -> Property
rightFace =
    fromEncoder "rightFace" Encode.string


topFace : String -> Property
topFace =
    fromEncoder "topFace" Encode.string


bottomFace : String -> Property
bottomFace =
    fromEncoder "bottomFace" Encode.string


frontFace : String -> Property
frontFace =
    fromEncoder "frontFace" Encode.string


backface : String -> Property
backface =
    fromEncoder "backface" Encode.string


stroke : Int -> Property
stroke =
    fromEncoder "stroke" Encode.int


enableStroke : Bool -> Property
enableStroke =
    fromEncoder "stroke" Encode.bool


fill : Bool -> Property
fill =
    fromEncoder "fill" Encode.bool


closed : Bool -> Property
closed =
    fromEncoder "closed" Encode.bool


radius : Float -> Property
radius =
    fromEncoder "radius" Encode.float


sides : Int -> Property
sides =
    fromEncoder "sides" Encode.int


cornerRadius : Float -> Property
cornerRadius =
    fromEncoder "cornerRadius" Encode.float


fromEncoder : String -> (a -> Value) -> a -> Property
fromEncoder name f a =
    Property name (f a)


vector : String -> Vector -> Property
vector name =
    fromEncoder name Vector.encode
