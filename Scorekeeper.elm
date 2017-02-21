module Scorekeeper exposing (..)

import Html exposing (Html)
import Html.Events as Events
import Html.Attributes as Attributes


type alias Model =
    { redScore : Int
    , blueScore : Int
    }


type Msg
    = IncrementRed
    | DecrementRed
    | IncrementBlue
    | DecrementBlue


button : String -> Msg -> Html Msg
button text message =
    Html.button [ Events.onClick message ] [ Html.text text ]


view : Model -> Html Msg
view model =
    Html.div []
        [ Html.div [ Attributes.style [ ( "color", "red" ) ] ]
            [ button "-" DecrementRed
            , Html.text (toString model.redScore)
            , button "+" IncrementRed
            ]
        , Html.div [ Attributes.style [ ( "color", "blue" ) ] ]
            [ button "-" DecrementBlue
            , Html.text (toString model.blueScore)
            , button "+" IncrementBlue
            ]
        ]


update : Msg -> Model -> Model
update message model =
    case message of
        IncrementRed ->
            { redScore = model.redScore + 1, blueScore = model.blueScore }

        DecrementRed ->
            { redScore = model.redScore - 1, blueScore = model.blueScore }

        IncrementBlue ->
            { redScore = model.redScore, blueScore = model.blueScore + 1 }

        DecrementBlue ->
            { redScore = model.redScore, blueScore = model.blueScore - 1 }


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = { redScore = 0, blueScore = 0 }
        , view = view
        , update = update
        }
