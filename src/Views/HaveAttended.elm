module Views.HaveAttended exposing (content)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)

import Model exposing (..)
import Actions exposing (..)

content : Model -> Html Action
content model =
  div []
    [ a [ class "btn btn-green", onClick (updateAction True) ] [ text "yes" ]
    , a [ class "btn btn-red", onClick (updateAction False) ] [ text "no" ]
    ]

updateAction : Bool -> Action
updateAction bool =
  UpdateRow (UpdateAttendedPreviously bool)
