module Functions exposing (diagramas)

import Html exposing (Html)
import Svg exposing (svg)
import Svg.Attributes as SvgA
import Types exposing (..)


diagramas : Model -> Html Msg
diagramas model =
    let
        l : Int
        l =
            List.length model.serie

        fl : Float
        fl =
            toFloat l

        sigma0 : Int
        sigma0 =
            Maybe.withDefault 0 (List.head model.serie)

        -- ajuste cuadrático para que no se salga del recuadro el 0
        -- es continuo en (8,4) para que no haya mucho salto
        small : Float
        small =
            if l < 8 then
                (fl * fl) / 8.0 - 2 * fl + 12

            else
                4.0

        -- coordenada polar de ángulo, en unidades de elm
        -- el 0.75 es para que el 0 esté arriba
        -- y el ajuste final es para que sigma0 esté arriba
        theta : Int -> Float
        theta x =
            turns
                ((toFloat x / fl)
                    + 0.75
                    + (if model.rotar then
                        negate (toFloat sigma0) / fl

                       else
                        0
                      )
                )

        -- lista de coordenadas cartesianas
        -- dado el radio y la lista con el orden de giros
        convertirEnCoordCart : Float -> List Int -> List ( Float, Float )
        convertirEnCoordCart radio lista =
            List.map
                fromPolar
                (List.map2
                    (\a b -> ( a, b ))
                    (List.repeat (List.length lista) (radio * fl))
                    (List.map theta lista)
                )
    in
    Svg.svg
        [ SvgA.version "1.1"
        , SvgA.x "0"
        , SvgA.y "0"
        , SvgA.viewBox
            ("-"
                ++ String.fromInt (4 * l)
                ++ " -"
                ++ String.fromFloat (small * fl)
                -- 4 si l grande
                ++ " "
                ++ String.fromInt (8 * l)
                ++ " "
                ++ String.fromFloat (2 * small * fl)
             -- 8 si l grande
            )
        , SvgA.width "100%"
        , SvgA.height
            (String.fromFloat
                -- ajuste para que el recuadro se haga más grande
                (90 * logBase 2 (fl + 1))
             -- lentamente con la magnitud de l
            )
        ]
        -- numeritos
        -- (Int -> a -> b) -> List a -> List b
        (List.indexedMap
            (\i coord ->
                Svg.text_
                    [ SvgA.x (String.fromFloat (Tuple.first coord))
                    , SvgA.y (String.fromFloat (Tuple.second coord + 3))
                    , SvgA.fontFamily "calibri"
                    , SvgA.fontSize "12"
                    , SvgA.textAnchor "middle"
                    ]
                    [ Svg.text (String.fromInt i) ]
             -- el numerito escrito es el índice
            )
            (convertirEnCoordCart 3.0 (List.range 0 (l - 1)))
            -- y estas son las coord
            ++ -- línea
               [ Svg.polyline
                    [ SvgA.points
                        (List.foldl
                            -- en vez de una lista de coordenadas
                            (\coord str ->
                                -- hay que dar una string con las coord
                                str
                                    ++ " "
                                    ++ String.fromFloat (Tuple.first coord)
                                    ++ ","
                                    ++ String.fromFloat (Tuple.second coord)
                            )
                            ""
                            (convertirEnCoordCart (3.0 - (6 / fl))
                                (if model.ultimo then
                                    model.serie ++ [ Maybe.withDefault 0 (List.head model.serie) ]

                                 else
                                    model.serie
                                )
                            )
                         -- y estas son las coord
                        )
                    , SvgA.style "fill:none;stroke:black;stroke-width:0.5"
                    , SvgA.markerStart "url(#flechita)"
                    ]
                    []

               -- la flecha que indica el inicio de la permutación
               , Svg.defs []
                    [ Svg.marker
                        [ SvgA.id "flechita"
                        , SvgA.markerWidth "100"
                        , SvgA.markerHeight "100"
                        , SvgA.refX "0" --(String.fromFloat (3*(logBase 10 fl)))
                        , SvgA.refY (String.fromFloat (9 * logBase 10 fl))
                        , SvgA.orient "auto"
                        ]
                        [ Svg.path
                            [ SvgA.d
                                ("M"
                                    ++ String.fromFloat (3 * logBase 10 fl)
                                    ++ ","
                                    ++ String.fromFloat (3 * logBase 10 fl)
                                    ++ " L"
                                    ++ String.fromFloat (3 * logBase 10 fl)
                                    ++ ","
                                    ++ String.fromFloat (16.5 * logBase 10 fl)
                                    ++ " L"
                                    ++ String.fromFloat (15 * logBase 10 fl)
                                    ++ ","
                                    ++ String.fromFloat (9 * logBase 10 fl)
                                    ++ " L"
                                    ++ String.fromFloat (3 * logBase 10 fl)
                                    ++ ","
                                    ++ String.fromFloat (3 * logBase 10 fl)
                                )
                            , SvgA.style "fill:#000000;"
                            , SvgA.scale "3"
                            ]
                            []
                        ]
                    ]
               ]
        )
