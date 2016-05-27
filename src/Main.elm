port module Main exposing (..)

import Html.App as Html
import Json.Decode as Decode
import Maybe exposing ( Maybe(..) )
import Array

import Model exposing (..)
import Actions exposing (..)

import View

main =
  Html.program
    { init = init
    , view = View.render
    , update = update
    , subscriptions = subscriptions
    }


init : (Model, Cmd msg)
init =
  ( Model "" Nothing [], Cmd.none )


-- UPDATE

port save : Model -> Cmd msg
port location : String -> Cmd msg
port confirm : String -> Cmd msg


update : Action -> Model -> (Model, Cmd Action)
update msg model =
  case msg of
    Load updated ->
      ( updated, Cmd.none )

    Increment ->
      {model | currentRow = (Just defaultRow)}
        |> changeRoute "#/have_attended"
        |> persist2

    RouteToHome ->
      {model | currentRow = Nothing}
        |> changeRoute ""
        |> persist2

    RouteToSettings ->
      model
        |> changeRoute "#/settings"
        |> persist2

    RouteToStats ->
      model
        |> changeRoute "#/stats"
        |> persist2

    UpdateRow (UpdateAttendedPreviously bool) ->
      let
        update = \row -> {row | attendedPreviously = bool}
      in
        updateRow model update
          |> changeRoute "#/passenger_count"
          |> persist2

    UpdateRow (UpdatePassengers count) ->
      let
        update = \row -> {row | passengers = count}
      in
        updateRow model update
          |> changeRoute "#/source"
          |> persist2

    UpdateRow (UpdateSource source) ->
      let
        update = \row -> {row | source = source}
      in
        updateRow model update
          |> saveCurrentRow
          |> changeRoute ""
          |> persist2

    ShowConfirm message ->
      ( model, confirm message )

    Confirmed confirmed ->
      if model.route == "#/settings" then
         handleConfirmResetData model confirmed
      else
        ( model, Cmd.none )

    ResetData ->
      init |> persist2

    UpdateRow _ ->
      ( model, Cmd.none )


handleConfirmResetData : Model -> Bool -> (Model, Cmd Action)
handleConfirmResetData model confirmed =
  if confirmed then
      init |> persist2
  else
    model |> changeRoute "" |> persist2


updateRow : Model -> (Row -> Row) -> Model
updateRow model rowFunction =
  let
      row = (Maybe.withDefault defaultRow model.currentRow)
        |> rowFunction
  in
     {model | currentRow = (Just row)}


saveCurrentRow : Model -> Model
saveCurrentRow model =
  case model.currentRow of
    Nothing ->
      model

    (Just row) ->
      { model |
        currentRow = Nothing,
        rows = model.rows ++ [row]
      }


changeRoute : String -> Model -> (Model, Cmd Action)
changeRoute newRoute model =
  ( {model | route = newRoute}, location newRoute )


persist2 : (Model, Cmd Action) -> (Model, Cmd Action)
persist2 (model, cmd) =
  ( model, Cmd.batch [ cmd, (save model) ] )


persist : Model -> (Model, Cmd Action)
persist model =
  ( model, save model )


-- SUBSCRIPTIONS


port storage : (Model -> msg) -> Sub msg
port confirmed : (Bool -> msg) -> Sub msg


subscriptions : Model -> Sub Action
subscriptions model =
  Sub.batch
    [ storage Load
    , confirmed Confirmed
    ]

