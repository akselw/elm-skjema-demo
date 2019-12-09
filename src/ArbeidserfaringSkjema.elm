module ArbeidserfaringSkjema exposing
    ( ArbeidserfaringSkjema
    , ValidertArbeidserfaringSkjema
    , arbeidsoppgaver
    , encode
    , feilmeldingFraÅr
    , feilmeldingStilling
    , feilmeldingTilÅr
    , fraMåned
    , fraÅr
    , init
    , nåværende
    , oppdaterArbeidsoppgaver
    , oppdaterFraMåned
    , oppdaterFraÅr
    , oppdaterStilling
    , oppdaterTilMåned
    , oppdaterTilÅr
    , stilling
    , tilMåned
    , tilÅr
    , toggleNåværende
    , valider
    , visAlleFeilmeldinger
    , visFeilmeldingFraÅr
    , visFeilmeldingStilling
    , visFeilmeldingTilÅr
    )

import Dato exposing (Måned(..), År)
import Json.Encode


type ArbeidserfaringSkjema
    = ArbeidserfaringSkjema
        { stilling : String
        , arbeidsoppgaver : String
        , fraMåned : Måned
        , fraÅr : String
        , tilMåned : Måned
        , tilÅr : String
        , nåværende : Bool
        , visFeilmeldingStilling : Bool
        , visFeilmeldingFraÅr : Bool
        , visFeilmeldingTilÅr : Bool
        }



--- INIT ---


init : ArbeidserfaringSkjema
init =
    ArbeidserfaringSkjema
        { stilling = ""
        , arbeidsoppgaver = ""
        , fraMåned = Januar
        , fraÅr = ""
        , tilMåned = Januar
        , tilÅr = ""
        , nåværende = False
        , visFeilmeldingStilling = False
        , visFeilmeldingFraÅr = False
        , visFeilmeldingTilÅr = False
        }



--- INNHOLD ---


stilling : ArbeidserfaringSkjema -> String
stilling (ArbeidserfaringSkjema skjema) =
    skjema.stilling


arbeidsoppgaver : ArbeidserfaringSkjema -> String
arbeidsoppgaver (ArbeidserfaringSkjema skjema) =
    skjema.arbeidsoppgaver


fraMåned : ArbeidserfaringSkjema -> Måned
fraMåned (ArbeidserfaringSkjema skjema) =
    skjema.fraMåned


fraÅr : ArbeidserfaringSkjema -> String
fraÅr (ArbeidserfaringSkjema skjema) =
    skjema.fraÅr


tilMåned : ArbeidserfaringSkjema -> Måned
tilMåned (ArbeidserfaringSkjema skjema) =
    skjema.tilMåned


tilÅr : ArbeidserfaringSkjema -> String
tilÅr (ArbeidserfaringSkjema skjema) =
    skjema.tilÅr


nåværende : ArbeidserfaringSkjema -> Bool
nåværende (ArbeidserfaringSkjema skjema) =
    skjema.nåværende



--- OPPDATERING ---


oppdaterStilling : String -> ArbeidserfaringSkjema -> ArbeidserfaringSkjema
oppdaterStilling stilling_ (ArbeidserfaringSkjema skjema) =
    ArbeidserfaringSkjema { skjema | stilling = stilling_ }


oppdaterArbeidsoppgaver : String -> ArbeidserfaringSkjema -> ArbeidserfaringSkjema
oppdaterArbeidsoppgaver arbeidsoppgaver_ (ArbeidserfaringSkjema skjema) =
    ArbeidserfaringSkjema { skjema | arbeidsoppgaver = arbeidsoppgaver_ }


oppdaterFraMåned : Måned -> ArbeidserfaringSkjema -> ArbeidserfaringSkjema
oppdaterFraMåned fraMåned_ (ArbeidserfaringSkjema skjema) =
    ArbeidserfaringSkjema { skjema | fraMåned = fraMåned_ }


oppdaterFraÅr : String -> ArbeidserfaringSkjema -> ArbeidserfaringSkjema
oppdaterFraÅr fraÅr_ (ArbeidserfaringSkjema skjema) =
    ArbeidserfaringSkjema { skjema | fraÅr = fraÅr_ }


oppdaterTilMåned : Måned -> ArbeidserfaringSkjema -> ArbeidserfaringSkjema
oppdaterTilMåned tilMåned_ (ArbeidserfaringSkjema skjema) =
    ArbeidserfaringSkjema { skjema | tilMåned = tilMåned_ }


oppdaterTilÅr : String -> ArbeidserfaringSkjema -> ArbeidserfaringSkjema
oppdaterTilÅr tilÅr_ (ArbeidserfaringSkjema skjema) =
    ArbeidserfaringSkjema { skjema | tilÅr = tilÅr_ }


toggleNåværende : ArbeidserfaringSkjema -> ArbeidserfaringSkjema
toggleNåværende (ArbeidserfaringSkjema skjema) =
    ArbeidserfaringSkjema { skjema | nåværende = not skjema.nåværende }



--- FEILMELDINGER ---


feilmeldingStilling : ArbeidserfaringSkjema -> Maybe String
feilmeldingStilling (ArbeidserfaringSkjema skjema) =
    if skjema.visFeilmeldingStilling then
        feilmeldingStillingTekst skjema.stilling

    else
        Nothing


feilmeldingStillingTekst : String -> Maybe String
feilmeldingStillingTekst stilling_ =
    if (String.trim >> String.isEmpty) stilling_ then
        Just "Vennligst fyll ut stilling"

    else
        Nothing


feilmeldingFraÅr : ArbeidserfaringSkjema -> Maybe String
feilmeldingFraÅr (ArbeidserfaringSkjema skjema) =
    if skjema.visFeilmeldingFraÅr then
        Dato.feilmeldingÅr skjema.fraÅr

    else
        Nothing


feilmeldingTilÅr : ArbeidserfaringSkjema -> Maybe String
feilmeldingTilÅr (ArbeidserfaringSkjema skjema) =
    if skjema.visFeilmeldingTilÅr then
        Dato.feilmeldingÅr skjema.tilÅr

    else
        Nothing


visFeilmeldingStilling : ArbeidserfaringSkjema -> ArbeidserfaringSkjema
visFeilmeldingStilling (ArbeidserfaringSkjema skjema) =
    ArbeidserfaringSkjema { skjema | visFeilmeldingStilling = True }


visFeilmeldingFraÅr : ArbeidserfaringSkjema -> ArbeidserfaringSkjema
visFeilmeldingFraÅr (ArbeidserfaringSkjema skjema) =
    ArbeidserfaringSkjema { skjema | visFeilmeldingFraÅr = True }


visFeilmeldingTilÅr : ArbeidserfaringSkjema -> ArbeidserfaringSkjema
visFeilmeldingTilÅr (ArbeidserfaringSkjema skjema) =
    ArbeidserfaringSkjema { skjema | visFeilmeldingTilÅr = True }


visAlleFeilmeldinger : ArbeidserfaringSkjema -> ArbeidserfaringSkjema
visAlleFeilmeldinger skjema =
    skjema
        |> visFeilmeldingStilling
        |> visFeilmeldingFraÅr
        |> visFeilmeldingTilÅr



--- VALIDERING ---


type ValidertArbeidserfaringSkjema
    = ValidertArbeidserfaringSkjema
        { stilling : String
        , arbeidsoppgaver : Maybe String
        , fraMåned : Måned
        , fraÅr : År
        , tilDato : SluttDato
        }


type SluttDato
    = Nåværende
    | Avsluttet Måned År


valider : ArbeidserfaringSkjema -> Maybe ValidertArbeidserfaringSkjema
valider ((ArbeidserfaringSkjema skjema) as uvalidertSkjema) =
    if feilmeldingStillingTekst skjema.stilling /= Nothing then
        Nothing

    else
        Maybe.map2 (initValidertSkjema uvalidertSkjema)
            (Dato.stringTilÅr skjema.fraÅr)
            (validerTilDato
                skjema.nåværende
                skjema.tilMåned
                skjema.tilÅr
            )


validerTilDato : Bool -> Måned -> String -> Maybe SluttDato
validerTilDato nåværende_ tilMåned_ tilÅr_ =
    if nåværende_ then
        Just Nåværende

    else
        tilÅr_
            |> Dato.stringTilÅr
            |> Maybe.map (Avsluttet tilMåned_)


initValidertSkjema : ArbeidserfaringSkjema -> År -> SluttDato -> ValidertArbeidserfaringSkjema
initValidertSkjema (ArbeidserfaringSkjema uvalidert) fraÅr_ sluttDato =
    ValidertArbeidserfaringSkjema
        { stilling = uvalidert.stilling
        , fraMåned = uvalidert.fraMåned
        , fraÅr = fraÅr_
        , tilDato = sluttDato
        , arbeidsoppgaver =
            if (String.trim >> String.isEmpty) uvalidert.arbeidsoppgaver then
                Nothing

            else
                Just uvalidert.arbeidsoppgaver
        }



--- ENCODE ---


encode : ValidertArbeidserfaringSkjema -> Json.Encode.Value
encode (ValidertArbeidserfaringSkjema skjema) =
    [ [ ( "stilling", Json.Encode.string skjema.stilling )
      , ( "beskrivelse"
        , skjema.arbeidsoppgaver
            |> Maybe.map Json.Encode.string
            |> Maybe.withDefault Json.Encode.null
        )
      , ( "fraDato", Dato.encodeMonthYear skjema.fraMåned skjema.fraÅr )
      ]
    , case skjema.tilDato of
        Nåværende ->
            [ ( "nåværende", Json.Encode.bool True )
            , ( "tilDato", Json.Encode.null )
            ]

        Avsluttet måned år ->
            [ ( "nåværende", Json.Encode.bool False )
            , ( "tilDato", Dato.encodeMonthYear måned år )
            ]
    ]
        |> List.concat
        |> Json.Encode.object
