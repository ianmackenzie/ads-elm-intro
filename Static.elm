module Static exposing (..)

import Html
import Html.Attributes as Attributes


main =
    Html.code [ Attributes.style [ ( "border", "1px solid black" ) ] ]
        [ Html.text "Hello world!" ]
