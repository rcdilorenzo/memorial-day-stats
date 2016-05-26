module Views.Source exposing (content)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)

import Model exposing (..)
import Actions exposing (..)

content : Model -> Html Action
content model =
  div [ class "btn-container" ]
    [ sourceButton "Unknown"
    , sourceButton "Banners"
    , sourceButton "Flyers"
    , sourceButton "Website"
    , sourceButton "Social Media"
    , sourceButton "Word of Mouth"
    , sourceButton "Backlink"
    ]


sourceButton : String -> Html Action
sourceButton source =
  span [ class "btn-span btn-fixed" ]
    [ a [ onClick (updateAction source) ] [ text source ] ]


updateAction : String -> Action
updateAction source =
  UpdateRow (UpdateSource source)

