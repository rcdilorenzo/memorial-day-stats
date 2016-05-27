module Views.Settings exposing (content)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)

import Model exposing (..)
import Actions exposing (..)

content : Model -> Html Action
content model =
  div [ class "btn-container settings-btn-container" ]
    [ span [ class "btn-span settings-btn-span" ]
      [ a [ class "settings-btn settings-btn-stats yellow", onClick RouteToStats ] [ text "stats" ] ]
    , span [ class "btn-span settings-btn-span" ]
      [ a [ class "settings-btn settings-btn-reset red", onClick ResetData ] [ text "reset all data?" ]
      ]
    ]
