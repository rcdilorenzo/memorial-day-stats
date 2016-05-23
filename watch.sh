#!/bin/bash

if [ ! `pgrep -n elm` ]; then
  echo "You need to install elm. Please visit the elm website and install before re-running this script."
  open http://elm-lang.org/install
  exit 1
fi

echo "Watching for changes..."
fswatch -0 src/ | xargs -0 -n 1 -I {} ./build.sh
