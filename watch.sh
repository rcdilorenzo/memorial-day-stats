#!/bin/bash

echo "Watching for changes..."
fswatch -0 src/ | xargs -0 -n 1 -I {} ./build.sh
