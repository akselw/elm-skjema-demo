module FrontendModuler.Textarea exposing (..)

import Html exposing (Html, div, label, p, text)
import Html.Attributes exposing (..)
import Html.Attributes.Aria exposing (ariaLive, role)
import Html.Events exposing (onInput)


html =
    div [ class "skjemaelement textarea__container" ]
        [ label [ class "skjemaelement__label" ] [ text "Label" ]
        , div [ class "textarea--medMeta__wrapper" ]
            [ Html.textarea
                [ classList
                    [ ( "skjemaelement__input textarea--medMeta overflow-auto-textbox", True )
                    , ( "skjemaelement__input--harFeil", False ) --TODO: False skal ikke være hardkodet
                    ]
                , value "Innhold" --TODO: "Innhold" skal ikke være hardkodet

                --, onInput () --TODO: () skal være en msg
                ]
                []
            ]
        , div [ role "alert", ariaLive "assertive" ]
            --TODO: Feilmelding skal ikke alltid vises
            [ div [ class "skjemaelement__feilmelding" ]
                [ text "Feilmelding" --TODO: "Feilmelding" skal ikke være hardkodet
                ]
            ]
        ]
