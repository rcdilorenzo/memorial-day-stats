port module Main exposing (..)

import Html.App as Html
import Json.Decode as Decode
import Maybe exposing ( Maybe(..) )

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
  ( Model 0 "" Nothing [], Cmd.none )


-- UPDATE

port save : Model -> Cmd msg
port location : String -> Cmd msg


update : Action -> Model -> (Model, Cmd Action)
update msg model =
  case msg of
    Load updated ->
      ( updated, Cmd.none )

    Increment ->
      { model |
        count = model.count + 1,
        currentRow = (Just defaultRow)
      }
        |> changeRoute "#/have_attended"
        |> persist2

    RouteToHome ->
      {model | currentRow = Nothing}
        |> changeRoute ""
        |> persist2

    UpdateRow (UpdateAttendedPreviously bool) ->
      let
          row = (Maybe.withDefault defaultRow model.currentRow)
          updatedRow = {row | attendedPreviously = bool}
      in
         {model | currentRow = (Just updatedRow)}
           |> changeRoute ""
           |> persist2

    UpdateRow _ ->
      ( model, Cmd.none )


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


subscriptions : Model -> Sub Action
subscriptions model =
  storage Load

