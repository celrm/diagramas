module Info exposing (informacion)

import Html exposing (..)
import Html.Attributes exposing (style)
import Markdown
import Styles exposing (..)
import Types exposing (..)


informacion : Html Msg
informacion =
    div
        [ style "width" "650px"
        , style "margin-left" "auto"
        , style "margin-right" "auto"
        ]
        [ Markdown.toHtml
            ( textStyle "20px"
            ++ [ style "text-align" "justify"
            ])
            texto
        , table
            [ style "width" "650px"
            , style "margin-bottom" "30px" ]
            [ td
                ( textStyle "20px"
                ++ [ style "width" "325px"
                ])
                [ text "I(σ(m)) = -σ(m) + 2σ(0)"
                , br [] []
                , text "T"
                , sup [] [ text "k" ]
                , text "(σ(m)) = σ(m) + k"
                , br [] []
                , text "R(σ(m)) = σ(-1-m)"
                , br [] []
                , text "C"
                , sup [] [ text "k" ]
                , text "(σ(m))=σ(m+k)"
                ]
            , td
                ( textStyle "20px"
                ++ [ style "width" "325px"
                ])
                [ text "S(σ(m)) = -σ(m)"
                , br [] []
                , text "T"
                , sup [] [ text "k" ]
                , text "(σ(m)) = σ(m) + k"
                , br [] []
                , text "V(σ(m)) = σ(-m)"
                , br [] []
                , text "C"
                , sup [] [ text "k" ]
                , text "(σ(m))=σ(m+k)"
                ]
            ]
        ]


texto =
    """

  # Más información:

  ## ¿Qué es un _diagrama de reloj_?

  Un diagrama de reloj es una representación visual de una serie musical. Se colocan los números del 0 al 11, o al `n-1` si la longitud de la serie es `n`, formando una circunferencia; como los números de un reloj. Después, se traza una línea empezando por la primera nota de la serie y pasando por cada nota en orden.

  ## ¿Para qué sirve?

  Un diagrama de reloj muestra con efectividad las características y la estructura interna que tiene la serie que representa. Se aprecia si tiene intervalos de tritono, porque son diagonales; si tiene notas consecutivas, o si tiene simetrías de algún tipo. Esta última propiedad es la más importante: singulariza a la serie y la hace más versátil a la hora de componer con ella y con sus derivadas. Los compositores serialistas siempre han dado un trato especial a las series simétricas, y ésta es una manera de visualizarlo.

  ## ¿Cómo se introduce la serie?

  La serie se introduce a través del cuadro de texto blanco. Acepta series numéricas de longitudes arbitrarias entre 1 y 100, con los números separados entre espacios. También se puede generar una permutación aleatoria de la longitud especificada en el recuadro pequeño, entre 1 y 100, tras pulsar el botón de OK.

  ## ¿Hay opciones de personalización?

  La casilla superior izquierda permite elegir entre tener arriba el `0` o la primera nota de la serie. La casilla superior derecha permite decidir si cerrar el diagrama; es decir, si unir la primera y la última nota.

  ## ¿Para qué sirven los botones?

  Los botones sirven para aplicar las funciones transformativas a la serie, y ver así cómo se comporta ante ellas. Además, es una forma sencilla y visual de encontrar las simetrías de la serie.

  Como hay dos conjuntos de transformaciones definidos, hay una opción para elegir entre ellos. Las diferencias están tan solo en el intercambio de la inversión y la simetría, y de la retrogradación y el volteo. Aquí están las fórmulas matemáticas de cada conjunto de funciones, aplicadas a una permutación σ(m):

"""
