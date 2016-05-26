module Views.PassengerCount exposing (content)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)

import Model exposing (Model)
import Actions exposing (..)

content : Model -> Html Action
content model =
  div [ class "btn-container" ]
    [ table [ class "btn-grid" ]
      [ tbody []
        [ tr [] [ cell 1, cell 2, cell 3 ]
        , tr [] [ cell 4, cell 5, cell 6 ]
        , tr [] [ cell 7, cell 8, cell 9 ]
        ]
      ]
    ]


cell : Int -> Html Action
cell int =
  td [ onClick (UpdateRow (UpdatePassengers int)) ]
    [ text (toString int) ]
