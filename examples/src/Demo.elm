module Demo exposing (..)

import Browser
import Html
import Zdog exposing (defaultZdog)
import Zdog.Shape as Shape
import Zdog.Properties exposing (..)


main : Program () () ()
main =
    Browser.element
        { init = init
        , view = always (Html.text "")
        , update = \_ model -> ( model, Cmd.none )
        , subscriptions = always Sub.none
        }


init : () -> ( (), Cmd msg )
init _ =
    ( ()
    , Zdog.illo
        { defaultZdog
            | model = dome -- how to draw a tangram?
            , width = Just 240
            , height = Just 240
            , dragRotate = True
        }
    )


dome : List Shape.Model
dome =
    [ Shape.hemisphere
        [ diameter 120
        , enableStroke False
        , color "#C25"
        , backface "#636"
        ]
    ]

