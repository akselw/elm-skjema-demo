module ArbeidserfaringSkjema exposing
    ( ArbeidserfaringSkjema
    , arbeidsoppgaver
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
    )

import Dato exposing (Måned(..))


type ArbeidserfaringSkjema
    = ArbeidserfaringSkjema
        { stilling : String
        , arbeidsoppgaver : String
        , fraMåned : Måned
        , fraÅr : String
        , tilMåned : Måned
        , tilÅr : String
        , nåværende : Bool
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
    if (String.trim >> String.isEmpty) skjema.stilling then
        Just "Vennligst full ut stilling"

    else
        Nothing


feilmeldingFraÅr : ArbeidserfaringSkjema -> Maybe String
feilmeldingFraÅr (ArbeidserfaringSkjema skjema) =
    Dato.feilmeldingÅr skjema.fraÅr


feilmeldingTilÅr : ArbeidserfaringSkjema -> Maybe String
feilmeldingTilÅr (ArbeidserfaringSkjema skjema) =
    Dato.feilmeldingÅr skjema.tilÅr
