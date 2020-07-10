module Demo exposing (..)

import Browser
import Html exposing (Html)
import Html.Attributes as Attributes
import Zdog exposing (defaultZdog)
import Zdog.Shape as Shape
import Zdog.Properties exposing (..)


main : Program () () ()
main =
    Browser.element
        { init = init
        , view = view
        , update = \_ model -> ( model, Cmd.none )
        , subscriptions = always Sub.none
        }


init : () -> ( (), Cmd msg )
init _ =
    ( ()
    , Cmd.none
    )


view : () -> Html msg
view _ =
    Zdog.canvas
        { defaultZdog | dragRotate = True
        }
        [ Attributes.width 240
        , Attributes.height 240
        ]
        dome


dome : List Shape.Model
dome =
    [ Shape.hemisphere
        [ diameter 120
        , enableStroke False
        , color "#C25"
        , backface "#636"
        ]
    ]

