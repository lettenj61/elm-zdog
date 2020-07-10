module Zdog exposing
    ( canvas, defaultZdog )

import Html exposing (Attribute, Html)
import Html.Attributes as Attributes
import Json.Decode exposing (Value)
import Json.Encode as Encode
import Zdog.Shape as Shape exposing (Shape(..))
import Zdog.Update as Update


type alias Config =
    { dragRotate : Bool
    , useAnimation : Bool
    }


defaultZdog : Config
defaultZdog =
    { dragRotate = False
    , useAnimation = False
    }


canvas : Config -> List (Attribute msg) -> List (Shape.Model) -> Html msg
canvas config attrs model =
    let
        myAttrs =
            [ Attributes.property "config" <| encodeConfig config
            , Attributes.property "model" <| Encode.list Shape.encode model
            , Attributes.attribute "operation" <| Update.toString Update.SetRoot
            ]
    in
    Html.node "elm-zdog-element"
        (myAttrs ++ attrs)
        []


encodeConfig : Config -> Value
encodeConfig { dragRotate, useAnimation } =
    Encode.object
        [ ( "dragRotate", Encode.bool dragRotate )
        , ( "useAnimation", Encode.bool useAnimation )
        ]
