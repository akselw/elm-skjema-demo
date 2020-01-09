module Api exposing (lagreArbeidserfaring)

import Http exposing (..)


lagreArbeidserfaring : (Result Error () -> msg) -> () -> Cmd msg
lagreArbeidserfaring msgConstructor validertSkjema =
    Http.post
        { url = "/api/cv/arbeidserfaring"
        , expect = expectWhatever msgConstructor
        , body =
            emptyBody
        }
