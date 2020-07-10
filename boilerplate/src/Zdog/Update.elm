module Zdog.Update exposing (Msg(..), toString)


type Msg
    = SetRoot
    | UpdateGraph


toString : Msg -> String
toString msg =
    case msg of
        SetRoot ->
            "0"

        UpdateGraph ->
            "1"