module Types exposing (..)


type alias Model =
    { serie : List Int
    , longitud : Int
    , rotar : Bool
    , ultimo : Bool
    , sch : Bool
    }


type Msg
  = Introducir String
  | KeepLong String
  | Aleatorio
  | Permutar (List Int)
  | Rotar Bool
  | Ultimo Bool
  | Sch Bool
  | Invertir
  | Transportar
  | Retrogradar
  | Ciclar
