module Model exposing (..)

import Maybe exposing ( Maybe(..) )
import Array exposing (fromList, length)
import List

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
