module Model exposing (..)

import Maybe exposing ( Maybe(..) )
import Array exposing (fromList, length)
import List exposing (unzip, map)
import Dict
import Dict.Extra exposing (groupBy)

type alias Model =
  { route: String
  , currentRow: Maybe Row
  , rows: List Row
  }

type alias Row =
  { passengers: Int
  , source: String
  , attendedPreviously: Bool
  }

defaultRow : Row
defaultRow = Row 0 "" False


vehicleCount : Model -> Int
vehicleCount model =
  fromList model.rows
    |> length


peopleCount : Model -> Int
peopleCount model =
  List.map (\row -> row.passengers) model.rows
    |> List.sum


sourceData : Model -> (List String, List Float)
sourceData model =
  let
      (labels, listOfRows) = groupBy .source model.rows
        |> Dict.toList
        |> unzip

      values = map (\row -> List.length row |> toFloat) listOfRows
  in
     (labels, values)
