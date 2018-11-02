module View exposing (view)

import Functions exposing (diagramas)
import Html exposing (..)
import Html.Attributes exposing (placeholder, checked, name, style, type_)
import Html.Events exposing (onCheck, onClick, onInput)
import Info exposing (informacion)
import Styles exposing (..)
import Types exposing (..)


doblecolumna : String -> List (Html Msg) -> List (Html Msg) -> Html Msg
doblecolumna s a b =
    div
        [ style "padding"
            (s
                ++ "px 0px "
                ++ (String.fromInt <| (\x -> 2 * x) <| Maybe.withDefault 0 <| String.toInt s)
                ++ "px 0px"
            )
        ]
        [ div [ style "float" "left", style "width" "50%" ]
            [ div [ style "float" "right", style "width" "400px" ]
                a
            ]
        , div [ style "float" "right", style "width" "50%" ]
            [ div [ style "float" "left", style "width" "400px" ]
                b
            ]
        ]


header : Html Msg
header =
    h1
        ( textStyle "2em" )
        [ text "DIAGRAMAS DE RELOJ" ]


opciones : Html Msg
opciones =
    doblecolumna "10"
        [ label
            ( textStyle "20px" )
            [ input
                [ type_ "checkbox"
                , checked False
                , onCheck Rotar
                ]
                []
            , text " Flecha de comienzo arriba"
            ]
        ]
        [ label
            ( textStyle "20px" )
            [ input
                [ type_ "checkbox"
                , checked False
                , onCheck Ultimo
                ]
                []
            , text " Cerrar línea final"
            ]
        ]


schoenberg : Html Msg
schoenberg =
    div [ style "margin-bottom" "-50px" ]
        [ label
            ( textStyle "20px" )
            [ input
                [ type_ "radio"
                , name "FunctionSet"
                , checked True
                , onClick (Sch True)
                ]
                []
            , text " I, T, R, C"
            ]
        , br [] []
        , label
            ( textStyle "20px" )
            [ input
                [ type_ "radio"
                , name "FunctionSet"
                , onClick (Sch False)
                ]
                []
            , text " S, T, V, C"
            ]
        ]


botoncitos : Bool -> Html Msg
botoncitos b =
    doblecolumna "75"
        [ button ( buttonStyle "200px" ++ [ onClick Invertir ])
            [ text
                (if b then
                    "Inversión"

                 else
                    "Simetría"
                )
            ]
        , br [] []
        , br [] []
        , button ( buttonStyle "200px" ++ [ onClick Transportar ])
            [ text "Transposición" ]
        ]
        [ button ( buttonStyle "200px" ++ [ onClick Retrogradar ])
            [ text
                (if b then
                    "Retrogradación"

                 else
                    "Volteo"
                )
            ]
        , br [] []
        , br [] []
        , button ( buttonStyle "200px" ++ [ onClick Ciclar ])
            [ text "Desp. cíclico" ]
        ]


originalrow : List Int -> Html Msg
originalrow r =
    div [ style "overflow" "auto" ]
        [ table
            tableStyle
            [ tr
                [ style "box-shadow" "5px 8px" ]
                (List.map
                    ((\a -> (\dividend modulus -> modBy modulus dividend) a (List.length r))
                        >> String.fromInt
                        >> (\x -> td boldStyle [ text x ])
                    )
                    r
                )
            ]
        ]


entrada : Html Msg
entrada =
    input
        ( fieldStyle
        ++ [ style "margin-top" "50px"
        , style "margin-bottom" "50px"
        , placeholder "4 5 7 1 6 3 8 2 11 0 9 10"
        , onInput Introducir
        ])
        []


bloquealeatorio : Html Msg
bloquealeatorio =
    div
        [ style "margin-top" "50px", style "margin-bottom" "50px" ]
        [ span
            (textStyle "20px")
            [ text "Serie aleatoria de longitud " ]
        , input
            ( squarefieldStyle "20px"
            ++ [ placeholder "12"
            , onInput KeepLong
            ])
            []
        , button ( littlebuttonStyle ++ [onClick Aleatorio ])
            [ text "OK" ]
        ]


view : Model -> Html Msg
view model =
    div  generalStyle 
        [ header
        , opciones
        , diagramas model
        , schoenberg
        , botoncitos model.sch
        , originalrow model.serie
        , entrada
        , bloquealeatorio
        , informacion
        ]
