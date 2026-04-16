#!/bin/bash

FOCUSED=$(aerospace list-workspaces --focused)
NON_EMPTY=$(aerospace list-workspaces --monitor all --empty no)

WORKSPACES=(1 2 3 4 5 6 7 8 9 A B C D E G I M N O P Q R S T U V W X Y Z)

ARGS=()
for ws in "${WORKSPACES[@]}"; do
  VISIBLE=off
  BG_DRAWING=off
  ICON_COLOR=0xffeba0ac

  if echo "$NON_EMPTY" | grep -qx "$ws"; then
    VISIBLE=on
  fi

  if [ "$ws" = "$FOCUSED" ]; then
    VISIBLE=on
    BG_DRAWING=on
    ICON_COLOR=0xff181825
  fi

  ARGS+=(--set "aerospace.$ws"
    drawing="$VISIBLE"
    background.drawing="$BG_DRAWING"
    icon.color="$ICON_COLOR"
  )
done

sketchybar "${ARGS[@]}"
