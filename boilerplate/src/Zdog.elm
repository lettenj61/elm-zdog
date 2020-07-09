port module Zdog exposing
    ( defaultZdog, illo )

import Json.Decode exposing (Value)
import Json.Encode as Encode
import Zdog.Shape as Shape exposing (Shape(..))


port requireIllo : Value -> Cmd msg


type alias Config =
    { dragRotate : Bool
    , useAnimation : Bool
    , width : Maybe Int
    , height : Maybe Int
    , model : List Shape.Model
    }


defaultZdog : Config
defaultZdog =
    { dragRotate = False
    , useAnimation = False
    , width = Nothing
    , height = Nothing
    , model = []
    }


illo : Config -> Cmd msg
illo { dragRotate, useAnimation, width, height, model } =
    requireIllo <|
        Encode.list
            identity
            [ Encode.object
                [ ( "dragRotate", Encode.bool dragRotate )
                , ( "useAnimation", Encode.bool useAnimation )
                , ( "width", width |> Maybe.map Encode.int |> Maybe.withDefault (Encode.int 480) )
                , ( "height", height |> Maybe.map Encode.int |> Maybe.withDefault (Encode.int 480) )
                ]
            , Encode.list Shape.encode model
            ]


type MyMsg
    = NewIllustration
    | NewAnimation