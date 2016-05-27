module Model exposing (..)

import Maybe exposing ( Maybe(..) )
import Array exposing (fromList, length)
import List exposing (unzip, map, filterMap, sum)
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


attendedPreviouslyCount : Model -> (Int, Int)
attendedPreviouslyCount model =
  let
      attendedPreviously = filterMap passengerCountFilterMap model.rows |> sum
      total = map (\row -> row.passengers) model.rows |> sum
  in
    (attendedPreviously, total)


passengerCountFilterMap : Row -> Maybe Int
passengerCountFilterMap row =
  if row.attendedPreviously then
     Just row.passengers
  else
    Nothing


attendedPreviouslyStatistic : Model -> String
attendedPreviouslyStatistic model =
  let
      (attendedPreviously, totalRows) = attendedPreviouslyCount model
      percentage = (toFloat attendedPreviously * 100) / (toFloat totalRows) |> round
  in
     (toString percentage) ++ "% (" ++ (toString attendedPreviously) ++ " people)"
