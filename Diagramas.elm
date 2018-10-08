module Main exposing (..)

import Html
import State exposing (init, update, subscriptions)
import View exposing (view)

main =
  Html.program
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }

{-
-círculos centrados? separación entre ellos?
-flecha
-}
