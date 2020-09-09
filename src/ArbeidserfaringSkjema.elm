module ArbeidserfaringSkjema exposing
    ( ArbeidserfaringSkjema
    , arbeidsoppgaver
    , fraMåned
    , fraÅr
    , init
    , nåværende
    , stilling
    , tilMåned
    , tilÅr
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
