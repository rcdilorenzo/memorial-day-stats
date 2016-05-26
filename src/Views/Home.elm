module Views.Home exposing (content)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)

import Model exposing (Model)
import Actions exposing (..)

content : Model -> Html Action
content model =
  div [ class "btn-container add-btn-container" ]
    [ div []
      [ span [ class "btn-span add-btn-span" ] [ a [ class "add-btn blue", onClick Increment ] [ text "+" ] ]
      ]
    , footerView (carsLabel model.count) "_ People"
    ]


footerView : String -> String -> Html Action
footerView left right =
  footer [ class "stats-container" ]
    [ div [ class "stats-item stats-cars" ] [ text left ]
    , div [ class "stats-item stats-people" ] [ text right ]
    ]


carsLabel : Int -> String
carsLabel count =
  (toString count) ++ " Cars"
