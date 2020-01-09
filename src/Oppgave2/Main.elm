module Oppgave2.Main exposing (..)

import Browser
import FrontendModuler.Input as Input
import FrontendModuler.Knapp as Knapp
import Html exposing (..)
import Html.Attributes exposing (..)
import Http



{--
Oppgave 2:
Lag et BilSkjema med følgende regler:
To felter:
- Registeringsnummer (Først 2 bokstaver, så 5 tall)
- Antall dører (Tall)

Skjemaet skal:
- Oppdateres når man skrive i feltene
- Vise feilmelding ved feil innhold
- Ikke vise feilmelding før feltet har mistet fokus (onBlur)
- Vis feilmelding på alle felter ved Lagre
- Kunne bli til et ValidertBilSkjema hvis begge feltene validere
- ValidertBilSkjema skal ha en encode
- Ha en funksjon i Api som tar et ValidertBilSkjema og returnerer en Cmd msg. (Akkurat som lagreArbeidserfaring)

--}


type Model
    = Model { skjema : BilSkjema }


type alias BilSkjema =
    ()



--- UPDATE ---


type Msg
    = LagreKnappTrykket
    | RegistreringsnummerOppdatert String
    | AntallDørerOppdatert String
    | ArbeidserfaringLagret (Result Http.Error ())


update : Msg -> Model -> ( Model, Cmd Msg )
update msg (Model model) =
    case msg of
        RegistreringsnummerOppdatert stilling ->
            ( Model model, Cmd.none )

        AntallDørerOppdatert arbeidsoppgaver ->
            ( Model model, Cmd.none )

        LagreKnappTrykket ->
            ( Model model, Cmd.none )

        ArbeidserfaringLagret result ->
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


viewSkjema : BilSkjema -> Html Msg
viewSkjema skjema =
    div []
        [ h1 [] [ text "Bil" ]
        , Input.input { msg = RegistreringsnummerOppdatert, label = "Registreringsnummer" } ""
            |> Input.toHtml
        , Input.input { msg = AntallDørerOppdatert, label = "Antall dører" } ""
            |> Input.withId "aar"
            |> Input.toHtml
        , Knapp.knapp LagreKnappTrykket "Lagre bil"
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
    ( Model { skjema = () }, Cmd.none )
