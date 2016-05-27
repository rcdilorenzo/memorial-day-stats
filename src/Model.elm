module Model exposing (..)

import Maybe exposing ( Maybe(..) )
import Array exposing (fromList, length)
import List exposing (unzip, map, filterMap, sum)
import Dict
import Time exposing (Time)
import Date
import Date.Format
import String exposing (join)
import Dict.Extra exposing (groupBy)

type alias Model =
  { route: String
  , currentRow: Maybe Row
  , toSave: List Row
  , rows: List Row
  }

type alias Row =
  { passengers: Int
  , source: String
  , attendedPreviously: Bool
  , timestamp : Time
  }

defaultRow : Row
defaultRow = Row 0 "" False 0


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


attendanceData : Model -> (List String, List Float)
attendanceData model =
  let
      hourOfRow = \row -> Time.inHours row.timestamp |> floor |> toFloat
      hoursToDescription = \hours -> (Time.hour * hours)
        |> Date.fromTime
        |> Date.Format.format "%I %p"

      (hours, listOfRows) = groupBy hourOfRow model.rows
        |> Dict.toList
        |> unzip

      values = map (\row -> List.length row |> toFloat) listOfRows
      labels = map hoursToDescription hours
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


toCSV : Model -> String
toCSV model =
  let
      headers = "Passengers,Attended Previously,Source,Timestamp"
  in
     headers :: (map rowToCSV model.rows)
      |> join "%0D%0A"


rowToCSV : Row -> String
rowToCSV row =
  let
      timestamp = row.timestamp
        |> Date.fromTime
        |> Date.Format.format "%m/%d/%Y %I:%M:%S %p"
      attrs =
        [ (toString row.passengers)
        , (if row.attendedPreviously then "Yes" else "No")
        , row.source
        , timestamp ]
  in
     join "," attrs
