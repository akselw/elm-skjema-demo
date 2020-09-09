module SkjemaDemo exposing (..)

import ArbeidserfaringSkjema as Skjema exposing (ArbeidserfaringSkjema)
import Browser
import Dato
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
    = NoeSkjedde
    | StillingOppdatert String
    | ArbeidsoppgaverOppdatert String
    | FraMånedOppdatert String
    | FraÅrOppdatert String
    | TilMånedOppdatert String
    | TilÅrOppdatert String
    | NåværendeToggled


update : Msg -> Model -> ( Model, Cmd Msg )
update msg (Model model) =
    case msg of
        NoeSkjedde ->
            ( Model model, Cmd.none )

        StillingOppdatert stilling ->
            ( Model { model | skjema = Skjema.oppdaterStilling stilling model.skjema }, Cmd.none )

        ArbeidsoppgaverOppdatert arbeidsoppgaver ->
            ( Model { model | skjema = Skjema.oppdaterArbeidsoppgaver arbeidsoppgaver model.skjema }, Cmd.none )

        FraMånedOppdatert fraMånedString ->
            case Dato.stringTilMaybeMåned fraMånedString of
                Just fraMåned ->
                    ( Model { model | skjema = Skjema.oppdaterFraMåned fraMåned model.skjema }, Cmd.none )

                Nothing ->
                    ( Model model, Cmd.none )

        FraÅrOppdatert fraÅr ->
            ( Model { model | skjema = Skjema.oppdaterFraÅr fraÅr model.skjema }, Cmd.none )

        TilMånedOppdatert tilMånedString ->
            case Dato.stringTilMaybeMåned tilMånedString of
                Just tilMåned ->
                    ( Model { model | skjema = Skjema.oppdaterTilMåned tilMåned model.skjema }, Cmd.none )

                Nothing ->
                    ( Model model, Cmd.none )

        TilÅrOppdatert tilÅr ->
            ( Model { model | skjema = Skjema.oppdaterTilÅr tilÅr model.skjema }, Cmd.none )

        NåværendeToggled ->
            ( Model { model | skjema = Skjema.toggleNåværende model.skjema }, Cmd.none )



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
            |> Input.input { msg = StillingOppdatert, label = "Stilling/yrke" }
            |> Input.withErObligatorisk
            |> Input.withFeilmelding (Skjema.feilmeldingStilling skjema)
            |> Input.toHtml
        , skjema
            |> Skjema.arbeidsoppgaver
            |> Textarea.textarea { msg = ArbeidsoppgaverOppdatert, label = "Arbeidsoppgaver" }
            |> Textarea.toHtml
        , div [ class "datoinputrad" ]
            [ DatoInput.datoInput
                { label = "Når startet du i jobben?"
                , onMånedChange = FraMånedOppdatert
                , måned = Skjema.fraMåned skjema
                , onÅrChange = FraÅrOppdatert
                , år = Skjema.fraÅr skjema
                }
                |> DatoInput.withFeilmeldingÅr (Skjema.feilmeldingFraÅr skjema)
                |> DatoInput.toHtml
            , if Skjema.nåværende skjema then
                text ""

              else
                DatoInput.datoInput
                    { label = "Når sluttet du i jobben?"
                    , onMånedChange = TilMånedOppdatert
                    , måned = Skjema.tilMåned skjema
                    , onÅrChange = TilÅrOppdatert
                    , år = Skjema.tilÅr skjema
                    }
                    |> DatoInput.withFeilmeldingÅr (Skjema.feilmeldingTilÅr skjema)
                    |> DatoInput.toHtml
            ]
        , skjema
            |> Skjema.nåværende
            |> Checkbox.checkbox "Jeg jobber fremdeles her" NåværendeToggled
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
