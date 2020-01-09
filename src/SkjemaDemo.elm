module SkjemaDemo exposing (..)

import Browser
import Dato exposing (Måned(..))
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


type alias ArbeidserfaringSkjema =
    { arbeidsoppgaver : String
    }



--- UPDATE ---


type Msg
    = ArbeidsoppgaverOppdatert String
    | Tekstmelding String
    | NoeSkjedde


update : Msg -> Model -> ( Model, Cmd Msg )
update msg (Model model) =
    case msg of
        ArbeidsoppgaverOppdatert stilling ->
            ( Model { model | skjema = oppdaterStilling stilling model.skjema }, Cmd.none )

        Tekstmelding string ->
            ( Model model, Cmd.none )

        NoeSkjedde ->
            ( Model model, Cmd.none )


oppdaterStilling : String -> ArbeidserfaringSkjema -> ArbeidserfaringSkjema
oppdaterStilling stilling skjema =
    { skjema | arbeidsoppgaver = stilling }



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
        , Input.input { msg = Tekstmelding, label = "Stilling/yrke" } ""
            |> Input.toHtml
        , Textarea.textarea { label = "Arbeidsoppgaver", msg = ArbeidsoppgaverOppdatert } skjema.arbeidsoppgaver
            |> Textarea.toHtml
        , div [ class "datoinputrad" ]
            [ DatoInput.datoInput
                { label = "Når startet du i jobben?"
                , onMånedChange = Tekstmelding
                , måned = Januar
                , onÅrChange = Tekstmelding
                , år = ""
                }
                |> DatoInput.toHtml
            , DatoInput.datoInput
                { label = "Når sluttet du i jobben?"
                , onMånedChange = Tekstmelding
                , måned = Januar
                , onÅrChange = Tekstmelding
                , år = ""
                }
                |> DatoInput.toHtml
            ]
        , Checkbox.checkbox "Jeg jobber fremdeles her" NoeSkjedde True
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
    ( Model { skjema = { arbeidsoppgaver = "" } }, Cmd.none )
