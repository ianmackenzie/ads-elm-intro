module Extract exposing (..)

import Html exposing (Html)
import Html.Events as Events


type Msg
    = Increment
    | Decrement


button : String -> Msg -> Html Msg
button text message =
    Html.button [ Events.onClick message ] [ Html.text text ]


view : Int -> Html Msg
view count =
    Html.div []
        [ button "-" Decrement
        , Html.text (toString count)
        , button "+" Increment
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
