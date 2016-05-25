module Views.Home exposing (content)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)

import Model exposing (Model)
import Actions exposing (..)

content : Model -> Html Action
content model =
  div [ class "btn-container add-btn-container" ]
    [ span [ class "btn-span add-btn-span" ] [ a [ class "add-btn blue", onClick Increment ] [ text "+" ] ]
    ]
