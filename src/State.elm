module State exposing (init, subscriptions, update)

import Random
import Random.List
import String
import Types exposing (..)


init : () -> ( Model, Cmd Msg )
init _ =
    ( { serie = [ 4, 5, 7, 1, 6, 3, 8, 2, 11, 0, 9, 10 ]
      , longitud = 12
      , rotar = False
      , ultimo = False
      , sch = True
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Introducir str ->
            let
                x =
                    str
                        |> String.words
                        |> List.map (String.toInt >> Maybe.withDefault 0)
            in
            ( { model
                | serie =
                    if List.length x > 100 then
                        model.serie

                    else
                        x
              }
            , Cmd.none
            )

        KeepLong str ->
            let
                n =
                    Maybe.withDefault 12 (String.toInt str)
            in
            ( { model
                | longitud =
                    clamp 1 100 n
              }
            , Cmd.none
            )

        Aleatorio ->
            ( model
            , Random.generate Permutar (Random.List.shuffle (List.range 0 (model.longitud - 1)))
            )

        Permutar x ->
            ( { model
                | serie = x
              }
            , Cmd.none
            )

        Rotar b ->
            ( { model | rotar = b }
            , Cmd.none
            )

        Ultimo b ->
            ( { model | ultimo = b }
            , Cmd.none
            )

        Sch b ->
            ( { model | sch = b }
            , Cmd.none
            )

        Invertir ->
            ( { model
                | serie =
                    if model.sch then
                        List.map
                            (\x ->
                                modBy (List.length model.serie) (-x + 2 * Maybe.withDefault 0 (List.head model.serie))
                            )
                            model.serie

                    else
                        List.map
                            (\x ->
                                modBy (List.length model.serie) -x
                            )
                            model.serie
              }
            , Cmd.none
            )

        Transportar ->
            ( { model
                | serie =
                    List.map
                        ((+) 1
                            >> (\b a -> (\dividend modulus -> modBy modulus dividend) a b) (List.length model.serie)
                        )
                        model.serie
              }
            , Cmd.none
            )

        Retrogradar ->
            ( { model
                | serie =
                    if model.sch then
                        List.reverse model.serie

                    else
                        Maybe.withDefault 0 (List.head model.serie)
                            :: List.reverse (Maybe.withDefault [] (List.tail model.serie))
              }
            , Cmd.none
            )

        Ciclar ->
            ( { model
                | serie =
                    Maybe.withDefault [] (List.tail model.serie)
                        ++ [ Maybe.withDefault 0 (List.head model.serie) ]
              }
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
