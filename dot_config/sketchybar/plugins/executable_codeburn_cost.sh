#!/bin/sh

COST=$(codeburn status --timezone Asia/Tokyo | awk '/Today/{print $2}')

if [ -n "$COST" ]; then
  sketchybar --set "$NAME" label="$COST"
fi
