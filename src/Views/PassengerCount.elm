module Views.PassengerCount exposing (content)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)

import Model exposing (Model)
import Actions exposing (..)

content : Model -> Html Action
content model =
  div [ class "btn-container passenger-btn-container" ]
    [ div [ class "btn-grid passenger-btn-grid" ]
        [ number 1, number 2, number 3, number 4, number 5, number 6, number 7 , number 8, number 9 ]
      ]


number : Int -> Html Action
number int =
  div [ class "btn-grid-item passenger-btn-grid-item yellow"
  , onClick (UpdateRow (UpdatePassengers int)) ]
    [ text (toString int) ]
