#!/bin/bash

elm-make src/Main.elm --output=app.js
python -m SimpleHTTPServer
open -g http://localhost:8000/
