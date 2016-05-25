module Views.HaveAttended exposing (content)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)

import Model exposing (..)
import Actions exposing (..)

content : Model -> Html Action
content model =
  div [ class "btn-container attended-btn-container" ]
    [ span [ class "btn-span attended-btn-span" ] [ a [ class "attended-btn attended-btn-yes green", onClick (updateAction True) ] [ text "yes" ] ]
    , span [ class "btn-span attended-btn-span" ] [ a [ class "attended-btn attended-btn-no red", onClick (updateAction False) ] [ text "no" ] ]
    ]

updateAction : Bool -> Action
updateAction bool =
  UpdateRow (UpdateAttendedPreviously bool)
