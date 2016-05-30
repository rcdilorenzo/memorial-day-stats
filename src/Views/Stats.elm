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
    div [ class "stats-full-container" ]
      [ div [ class "stats-container " ] [
        div [ class "stats-item stats-attended" ] [ text ((attendedPreviouslyStatistic model) ++ " Previously Attended") ]
        , div [ class "stats-item stats-cars" ] [ text (toString (Model.vehicleCount model) ++ " Cars") ]
        , div [ class "stats-item stats-people" ] [ text (toString (Model.peopleCount model) ++ " People") ]
      ]
      , div [ class "stats-item stats-source" ]
        [ pie values labels
          |> Chart.title "Sources"
          |> colors [ "#3498db", "#2ecc71", "#e74c3c", "#f1c40f", "#9b59b6", "#e67e22", "#95a5a6" ]
          |> updateStyles "container"
            [ ( "background-color", "transparent" )
            , ( "padding", "0" )
            , ( "display", "block" )
            , ( "flex-direction", "inherit" )
            ]
          |> updateStyles "chart-container"
            [ ( "display", "block" )
            , ( "background-color", "transparent" )
            , ( "padding", "0" )
            , ( "display", "flex" )
            ]
          |> updateStyles "chart"
            [ ( "background", "#3498db" )
            , ( "width", "50%" )
            , ( "height", "auto" )
            ]
          |> updateStyles "legend"
            [ ( "width", "50%" )
            , ( "height", "auto" )
            , ( "flex-basis", "auto" )
            ]
          |> toHtml
        ]
      , div [ class "stats-item stats-time" ]
        [ vBar attendanceValues attendanceLabels
          |> Chart.title "Attendance"
          |> updateStyles "container"
            [ ( "background-color", "transparent" )
            , ( "padding", "0" )
            , ( "display", "block" )
            , ( "flex-direction", "inherit" )
            ]
          |> updateStyles "chart-container"
            [ ( "display", "block" )
            , ( "background-color", "transparent" )
            , ( "padding", "0" )
            ]
          |> updateStyles "chart-elements"
            [ ( "background-color", "#95a5a6" )
            ]
          |> updateStyles "legend"
            [ ( "justify-content", "center" )
            ]
          |> toHtml
        ]
      ]
