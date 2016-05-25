module Views.Home exposing (content)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)

import Model exposing (Model)
import Actions exposing (..)

content : Model -> Html Action
content model =
  div [ class "button-container" ]
    [ span [ class "button-span" ] [ a [ class "center-button", onClick Increment ] [ text "+" ] ]
    ]
