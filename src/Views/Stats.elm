module Views.Stats exposing (content)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)

import Model exposing (..)
import Actions exposing (..)

content : Model -> Html Action
content model =
  div [ class "btn-container source-btn-container" ]
    [ div [ class "btn-grid source-btn-grid" ]
      [ text "Blah"
      ]
    ]
