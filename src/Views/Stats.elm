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
      (attendanceLabels, attendanceValues) = attendanceData model
  in
    div [ class "btn-container source-btn-container" ]
      [ b [ style [("color", "black")] ] [ text ("Previously Attended: " ++ (attendedPreviouslyStatistic model)) ]
      , b [ style [("color", "black")] ] [ text (toString (Model.vehicleCount model) ++ " Cars") ]
      , b [ style [("color", "black")] ] [ text (toString (Model.peopleCount model) ++ " People") ]
      , div [ class "btn-grid source-btn-grid" ]
        [ pie values labels
            |> Chart.title "Sources"
            |> updateStyles "legend" [("color", "black")]
            |> toHtml
        , vBar attendanceValues attendanceLabels
            |> Chart.title "Attendance"
            |> updateStyles "legend" [("color", "black")]
            |> toHtml
        ]
      ]
