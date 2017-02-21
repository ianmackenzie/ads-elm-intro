module Static exposing (..)

import Html
import Html.Attributes as Attributes


main =
    let
        style =
            Attributes.style [ ( "border", "1px solid black" ) ]
    in
        Html.code [ style ] [ Html.text "Hello world!" ]
