module Zdog.Shape exposing
    ( Shape, Model
    , encode
    , rect, roundedRect, ellipse, polygon, shape
    , hemisphere, cone, cylinder, box
    )

import Json.Decode exposing (Value)
import Json.Encode as Encode
import Zdog.Properties exposing (Property(..))



-- SHAPE


type Model
    = ShapeModel Shape (List Property)


type Shape
    = Rect
    | RoundedRect
    | Ellipse
    | Polygon
    | Shape
    | Hemisphere
    | Cone
    | Cylinder
    | Box


rect : List Property -> Model
rect =
    ShapeModel Rect


roundedRect : List Property -> Model
roundedRect =
    ShapeModel RoundedRect


ellipse : List Property -> Model
ellipse =
    ShapeModel Ellipse


polygon : List Property -> Model
polygon =
    ShapeModel Polygon


shape : List Property -> Model
shape =
    ShapeModel Shape


hemisphere : List Property -> Model
hemisphere =
    ShapeModel Hemisphere


cone : List Property -> Model
cone =
    ShapeModel Cone


cylinder : List Property -> Model
cylinder =
    ShapeModel Cylinder


box : List Property -> Model
box =
    ShapeModel Box


-- ENCODER


encode : Model -> Value
encode (ShapeModel tag props) =
    Encode.object <|
        ( "tag", Encode.int (shapeToTag tag) )
            :: List.map (\(Property key val) -> ( key, val )) props


shapeToTag : Shape -> Int
shapeToTag repr =
    case repr of
        Rect ->
            1

        RoundedRect ->
            2

        Ellipse ->
            3

        Polygon ->
            4

        Shape ->
            5

        Hemisphere ->
            6

        Cone ->
            7

        Cylinder ->
            8

        Box ->
            9