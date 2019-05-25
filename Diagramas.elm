module Main exposing (main)

import Browser
import State exposing (init, subscriptions, update)
import View exposing (view)


main =
    Browser.document
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
