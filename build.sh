#!/bin/bash

if [ ! `pgrep -n elm` ]; then
  echo "You need to install elm. Please visit the elm website and install before re-running this script."
  open http://elm-lang.org/install
  exit 1
fi

elm-make src/Main.elm --output=app.js
open -g index.html
