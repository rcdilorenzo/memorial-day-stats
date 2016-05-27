module View exposing (render)


import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)

import Model exposing (..)
import Actions exposing (..)
import Views.Home as Home
import Views.HaveAttended as HaveAttended
import Views.PassengerCount as PassengerCount
import Views.Source as Source
import Views.Stats as Stats
import Views.Settings as Settings


render : Model -> Html Action
render model =
  let
      ( title, content ) = renderView model
  in
     layout title model content


renderView : Model -> (String, Html Action)
renderView model =
  case model.route of
    "" ->
      ( "Home", Home.content model )

    "#/have_attended" ->
      ( "Previously Attended?", HaveAttended.content model )

    "#/passenger_count" ->
      ( "How Many Passengers?", PassengerCount.content model )

    "#/source" ->
      ( "Source?", Source.content model )

    "#/stats" ->
      ( "Stats", Stats.content model )

    "#/settings" ->
      ( "Settings", Settings.content model )

    _ ->
      ( "Memorial Day", notFound )


layout : String -> Model -> Html Action -> Html Action
layout title model content =
  div []
    [ navigationView title
    , content
    ]


navigationView : String -> Html Action
navigationView title =
  div [ class "navigation-container white" ]
    [ div [ class "navigation-item navigation-home" ]
      [ a [ onClick RouteToHome ] [ i [ class "fa fa-home" ] [] ] ]
    , h1 [ class "navigation-item navigation-title" ] [ text title ]
    , div [ class "navigation-item navigation-settings" ]
      [ a [ onClick RouteToSettings ] [ i [ class "fa fa-cogs" ] [] ] ]
    ]


notFound : Html Action
notFound =
  div []
    [ div [] [ text "Route Not Found" ]
    , p [] [ a [ onClick RouteToHome ] [ text "Go Home?" ] ]
    ]


