module Model exposing (..)

import Maybe exposing ( Maybe(..) )

type alias Model =
  { count: Int
  , route: String
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
