module Views.Stats exposing (content)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)

import Chart exposing (..)

import Model exposing (..)
import Actions exposing (..)

content : Model -> Html Action
content model =
  let
      (labels, values) = sourceData model
  in
    div [ class "btn-container source-btn-container" ]
      [ b [ style [("color", "black")] ] [ text ("Previously Attended: " ++ (attendedPreviouslyStatistic model)) ]
      , div [ class "btn-grid source-btn-grid" ]
        [ pie values labels
            |> Chart.title "Sources"
            |> updateStyles "legend" [("color", "black")]
            |> toHtml
        ]
      ]
