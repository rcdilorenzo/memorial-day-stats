module View exposing (render)


import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)

import Model exposing (..)
import Actions exposing (..)
import Views.Home as Home
import Views.HaveAttended as HaveAttended


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

    _ ->
      ( "Memorial Day", notFound )


layout : String -> Model -> Html Action -> Html Action
layout title model content =
  div []
    [ navigationView title
    , content
    , footerView (carsLabel model.count) "_ People"
    ]


navigationView : String -> Html Action
navigationView title =
  div [ class "navigation-container white" ]
    [ div [ class "navigation-item navigation-home" ]
      [ a [ onClick RouteToHome ] [ i [ class "fa fa-home" ] [] ] ]
    , h1 [ class "navigation-item navigation-title" ] [ text title ]
    , div [ class "navigation-item navigation-settings" ]
      [ a [ onClick RouteToHome ] [ i [ class "fa fa-cogs" ] [] ] ]
    ]


footerView : String -> String -> Html Action
footerView left right =
  footer [ class "stats-container" ]
    [ div [ class "stats-item stats-cars" ] [ text left ]
    , div [ class "stats-item stats-people" ] [ text right ]
    ]

notFound : Html Action
notFound =
  div []
    [ div [] [ text "Route Not Found" ]
    , p [] [ a [ onClick RouteToHome ] [ text "Go Home?" ] ]
    ]


carsLabel : Int -> String
carsLabel count =
  (toString count) ++ " Cars"
