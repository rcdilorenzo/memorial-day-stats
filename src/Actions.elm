module Actions exposing (..)

import Model exposing (Model)

type Action
  = Increment
  | RouteToHome
  | UpdateRow RowAction
  | Load Model

type RowAction
  = UpdateAttendedPreviously Bool
  | UpdatePassengers Int
  | UpdateSource String
  | SaveRow
