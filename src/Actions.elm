module Actions exposing (..)

import Time exposing (Time)

import Model exposing (Model)


type Action
  = Increment
  | RouteToHome
  | RouteToStats
  | RouteToSettings
  | ResetData
  | Identity
  | TimeFetched Time
  | UpdateRow RowAction
  | ShowConfirm String
  | Confirmed Bool
  | Load Model

type RowAction
  = UpdateAttendedPreviously Bool
  | UpdatePassengers Int
  | UpdateSource String
  | SaveRow
