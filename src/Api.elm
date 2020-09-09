module Api exposing (lagreArbeidserfaring)

import ArbeidserfaringSkjema exposing (ValidertArbeidserfaringSkjema)
import Http exposing (..)


lagreArbeidserfaring : (Result Error () -> msg) -> ValidertArbeidserfaringSkjema -> Cmd msg
lagreArbeidserfaring msgConstructor validertSkjema =
    Http.post
        { url = "/api/cv/arbeidserfaring"
        , expect = expectWhatever msgConstructor
        , body =
            emptyBody
        }
