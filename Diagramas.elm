module Main exposing (main)

import Browser
import State exposing (init, subscriptions, update)
import View exposing (view)


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



{-
   -círculos centrados? separación entre ellos?
   -flecha
-}
