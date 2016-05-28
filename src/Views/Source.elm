module Views.Source exposing (content)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)

import Model exposing (..)
import Actions exposing (..)

content : Model -> Html Action
content model =
  div [ class "btn-container source-btn-container" ]
    [ div [ class "btn-grid source-btn-grid" ]
      [ source "Unknown"
      , source "Banners"
      , source "Flyers"
      , source "Website"
      , source "Social Media"
      , source "Word of Mouth"
      , source "Backlink"
      ]
    ]


source : String -> Html Action
source source =
  div [ class "btn-grid-item source-btn-grid-item purple" ]
    [ a [ onClick (updateAction source) ] [ text source ] ]


updateAction : String -> Action
updateAction source =
  UpdateRow (UpdateSource source)
