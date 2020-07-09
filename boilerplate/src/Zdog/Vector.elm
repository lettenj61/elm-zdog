module Zdog.Vector exposing
    ( Vector
    , zero, setX, setY, setZ, setXY, setYZ, setXZ, setXYZ
    , encode
    )

import Json.Encode as Encode


type alias Vector =
    { x : Float
    , y : Float
    , z : Float
    }


zero : Vector
zero =
    { x = 0, y = 0, z = 0
    }



-- WITH PROPERTIES


setX : Float -> Vector
setX x =
    { zero | x = x }


setY : Float -> Vector
setY y =
    { zero | y = y }


setZ : Float -> Vector
setZ z =
    { zero | z = z }


setXY : Float -> Float -> Vector
setXY x y =
    { zero | x = x, y = y }


setYZ : Float -> Float -> Vector
setYZ y z =
    { zero | y = y, z = z }


setXZ : Float -> Float -> Vector
setXZ x z =
    { zero | x = x, z = z }


setXYZ : Float -> Float -> Float -> Vector
setXYZ =
    Vector



-- JSON


encode : Vector -> Encode.Value
encode { x, y, z } =
    Encode.object
        [ ( "x", Encode.float x )
        , ( "y", Encode.float y )
        , ( "z", Encode.float z )
        ]