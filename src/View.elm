module View exposing (view)

import Browser
import Functions exposing (diagramas)
import Html exposing (..)
import Html.Attributes exposing (placeholder, checked, name, style, type_, href)
import Html.Events exposing (onCheck, onClick, onInput)
import Info exposing (informacion)
import Styles exposing (..)
import Types exposing (..)
import Credits exposing (..)


opciones : Html Msg
opciones =
  let estiloLetra = textStyle "20px"
  in
    doblecolumna "10"
        [ label
            estiloLetra
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
            estiloLetra
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
  let estiloLetra = textStyle "20px"
  in
    div [ style "margin-bottom" "-50px" ]
        [ label
            estiloLetra
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
            estiloLetra
            [ input
                [ type_ "radio"
                , name "FunctionSet"
                , onClick (Sch False)
                ]
                []
            , text " S, T, V, C"
            ]
        ]


funcionicas : Bool -> Html Msg
funcionicas b =
  let estiloBoton accion =
        ( buttonStyle "200px" ++ [ onClick accion ] )
  in
    doblecolumna "75"
        [ button ( estiloBoton Invertir )
            [ text
                (if b then "Inversión"
                 else "Simetría")
            ]
        , br [] []
        , br [] []
        , button ( estiloBoton Transportar )
            [ text "Transposición" ]
        ]
        [ button ( estiloBoton Retrogradar )
            [ text
                (if b then "Retrogradación"
                  else "Volteo")
            ]
        , br [] []
        , br [] []
        , button ( estiloBoton Ciclar )
            [ text "Desp. cíclico" ]
        ]

view : Model -> Browser.Document Msg
view model =
  (Browser.Document "Diagramas"
    [ div  generalStyle
        [ navbar 2
        , titulo "DIAGRAMAS DE RELOJ"
        , opciones
        , diagramas model
        , schoenberg
        , funcionicas model.sch
        , bloquealeatorio (onInput KeepLong) (onClick Aleatorio)
        , br [] []
        , originalrow model.serie
        , entrada (onInput Introducir)
        , informacion
        , br [] []
        , credits
        ]
    ]
  )
