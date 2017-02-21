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


logEntry : String -> String -> Html Msg
logEntry color text =
    Html.div [ Attributes.style [ ( "color", color ) ] ] [ Html.text text ]


logEntries : Model -> Html Msg
logEntries model =
    case model.log of
        [] ->
            Html.div [] []

        first :: rest ->
            let
                firstEntry =
                    logEntry "black" first

                otherEntries =
                    List.map (logEntry "grey") (List.take 4 rest)
            in
                Html.div [] (firstEntry :: otherEntries)


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
            , logEntries model
            ]


update : Msg -> Model -> Model
update message model =
    case message of
        IncrementRed ->
            { redScore = model.redScore + 1
            , blueScore = model.blueScore
            , log = "Red scored!" :: model.log
            }

        DecrementRed ->
            { redScore = model.redScore - 1
            , blueScore = model.blueScore
            , log = "Point removed from red" :: model.log
            }

        IncrementBlue ->
            { redScore = model.redScore
            , blueScore = model.blueScore + 1
            , log = "Blue scored!" :: model.log
            }

        DecrementBlue ->
            { redScore = model.redScore
            , blueScore = model.blueScore - 1
            , log = "Point removed from blue" :: model.log
            }


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = { redScore = 0, blueScore = 0, log = [] }
        , view = view
        , update = update
        }
