module SkjemaDemo exposing (..)

import ArbeidserfaringSkjema as Skjema exposing (ArbeidserfaringSkjema)
import Browser
import FrontendModuler.Checkbox as Checkbox
import FrontendModuler.DatoInput as DatoInput
import FrontendModuler.Input as Input
import FrontendModuler.Knapp as Knapp
import FrontendModuler.Textarea as Textarea
import Html exposing (..)
import Html.Attributes exposing (..)



--- MODEL ---


type Model
    = Model { skjema : ArbeidserfaringSkjema }



--- UPDATE ---


type Msg
    = Tekstmelding String
    | NoeSkjedde


update : Msg -> Model -> ( Model, Cmd Msg )
update msg (Model model) =
    case msg of
        Tekstmelding string ->
            ( Model model, Cmd.none )

        NoeSkjedde ->
            ( Model model, Cmd.none )



--- VIEW ---


view : Model -> Html Msg
view (Model model) =
    div [ class "app" ]
        [ div [ class "cv-samtale" ]
            [ div [ class "samtale-wrapper" ]
                [ div [ class "samtale" ]
                    [ viewSkjema model.skjema ]
                ]
            ]
        ]


viewSkjema : ArbeidserfaringSkjema -> Html Msg
viewSkjema skjema =
    div []
        [ h1 [] [ text "Arbeidserfaring" ]
        , skjema
            |> Skjema.stilling
            |> Input.input { msg = Tekstmelding, label = "Stilling/yrke" }
            |> Input.toHtml
        , skjema
            |> Skjema.arbeidsoppgaver
            |> Textarea.textarea { msg = Tekstmelding, label = "Arbeidsoppgaver" }
            |> Textarea.toHtml
        , div [ class "datoinputrad" ]
            [ DatoInput.datoInput
                { label = "Når startet du i jobben?"
                , onMånedChange = Tekstmelding
                , måned = Skjema.fraMåned skjema
                , onÅrChange = Tekstmelding
                , år = Skjema.fraÅr skjema
                }
                |> DatoInput.toHtml
            , DatoInput.datoInput
                { label = "Når sluttet du i jobben?"
                , onMånedChange = Tekstmelding
                , måned = Skjema.tilMåned skjema
                , onÅrChange = Tekstmelding
                , år = Skjema.tilÅr skjema
                }
                |> DatoInput.toHtml
            ]
        , skjema
            |> Skjema.nåværende
            |> Checkbox.checkbox "Jeg jobber fremdeles her" NoeSkjedde
            |> Checkbox.withClass "blokk-m"
            |> Checkbox.toHtml
        , Knapp.knapp NoeSkjedde "Lagre arbeidserfaring"
            |> Knapp.toHtml
        ]



--- INIT ---


main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model { skjema = Skjema.init }, Cmd.none )
