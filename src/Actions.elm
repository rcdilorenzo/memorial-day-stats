module Actions exposing (..)

import Model exposing (Model)

type Action
  = Increment
  | RouteToHome
  | RouteToStats
  | RouteToSettings
  | ResetData
  | UpdateRow RowAction
  | ShowConfirm String
  | Confirmed Bool
  | Load Model

type RowAction
  = UpdateAttendedPreviously Bool
  | UpdatePassengers Int
  | UpdateSource String
  | SaveRow
