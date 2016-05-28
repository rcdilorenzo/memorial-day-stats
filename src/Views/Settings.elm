module Views.Settings exposing (content)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)

import Model exposing (..)
import Actions exposing (..)

content : Model -> Html Action
content model =
  let
      confirmAction = (ShowConfirm "Are you sure you want to reset ALL of the data?")
      export = "mailto:rcddeveloper@icloud.com?subject=Stats Export&body=" ++ (toCSV model)
  in
    div [ class "btn-container settings-btn-container" ]
      [ span [ class "btn-span settings-btn-span" ]
        [ a [ class "settings-btn settings-btn-stats orange", onClick RouteToStats ] [ text "stats" ] ]
      , span [ class "btn-span settings-btn-span" ]
        [ a [ class "settings-btn settings-btn-export grey", href export ] [ text "export" ] ]
      , span [ class "btn-span settings-btn-span" ]
        [ a [ class "settings-btn settings-btn-reset red", onClick confirmAction ] [ text "reset?" ] ]
      ]
