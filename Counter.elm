module Counter exposing (..)

import Html exposing (Html)
import Html.Events as Events


type Msg
    = Increment
    | Decrement


view : Int -> Html Msg
view count =
    Html.div []
        [ Html.button [ Events.onClick Decrement ] [ Html.text "-" ]
        , Html.text (toString count)
        , Html.button [ Events.onClick Increment ] [ Html.text "+" ]
        ]


update : Msg -> Int -> Int
update message model =
    case message of
        Increment ->
            model + 1

        Decrement ->
            model - 1


main : Program Never Int Msg
main =
    Html.beginnerProgram
        { model = 0
        , view = view
        , update = update
        }
