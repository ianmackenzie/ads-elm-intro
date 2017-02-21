module Logged exposing (..)

import Html exposing (Html)
import Html.Events as Events
import Html.Attributes as Attributes


type alias Model =
    { redScore : Int
    , blueScore : Int
    , log : List String
    }


type Msg
    = IncrementRed
    | DecrementRed
    | IncrementBlue
    | DecrementBlue


button : String -> Msg -> Html Msg
button text message =
    Html.button [ Events.onClick message ] [ Html.text text ]


logEntry : String -> Html Msg
logEntry text =
    Html.div [] [ Html.text text ]


view : Model -> Html Msg
view model =
    let
        outlineColor =
            if model.redScore > model.blueScore then
                "red"
            else if model.blueScore > model.redScore then
                "blue"
            else
                "gray"

        outlineStyle =
            Attributes.style [ ( "border", "1px solid " ++ outlineColor ) ]
    in
        Html.div []
            [ Html.div [ outlineStyle ]
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
            , Html.div [] (List.map logEntry model.log)
            ]


update : Msg -> Model -> Model
update message model =
    case message of
        IncrementRed ->
            { redScore = model.redScore + 1
            , blueScore = model.blueScore
            , log = model.log ++ [ "Red scored!" ]
            }

        DecrementRed ->
            { redScore = model.redScore - 1
            , blueScore = model.blueScore
            , log = model.log ++ [ "Point removed from red" ]
            }

        IncrementBlue ->
            { redScore = model.redScore
            , blueScore = model.blueScore + 1
            , log = model.log ++ [ "Blue scored!" ]
            }

        DecrementBlue ->
            { redScore = model.redScore
            , blueScore = model.blueScore - 1
            , log = model.log ++ [ "Point removed from blue" ]
            }


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = { redScore = 0, blueScore = 0, log = [] }
        , view = view
        , update = update
        }
