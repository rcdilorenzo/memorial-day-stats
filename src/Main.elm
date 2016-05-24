port module Main exposing (..)

import Html exposing (Html, button, div, text, h1, footer, a)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Json.Decode as Decode

main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


type alias Model =
  { count: Int
  }


init : (Model, Cmd msg)
init =
  ( Model 0, Cmd.none )


type Msg
  = Increment
  | Decrement
  | Load Model


-- UPDATE

port save : Model -> Cmd msg


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Increment ->
      persist (Model (model.count + 1))

    Decrement ->
      persist (Model (model.count - 1))

    Load updated ->
      ( updated, Cmd.none )


persist : Model -> (Model, Cmd Msg)
persist model =
  ( model, save model )


-- VIEW

carsLabel : Int -> String
carsLabel count =
  (toString count) ++ " Cars"


view : Model -> Html Msg
view model =
  div []
    [ navigationView "Celebrate Memorial Day"
    , a [ class "center-button", onClick Increment ] [ text "+" ]
    , footerView (carsLabel model.count) "_ People"
    ]


navigationView : String -> Html Msg
navigationView title =
  div [ class "navigation" ]
    [ h1 [ class "navigation-title" ] [ text title ] ]


footerView : String -> String -> Html Msg
footerView left right =
  footer [ class "stats" ]
    [ div [ class "stats-left" ] [ text left ]
    , div [ class "stats-right" ] [ text right ]
    ]


-- SUBSCRIPTIONS


port storage : (Model -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions model =
  storage Load

