#!/usr/bin/env bash

source "$CONFIG_DIR/plugins/icon_map.sh"

if [ "$SENDER" = "front_app_switched" ]; then
  __icon_map "$INFO"
  sketchybar --set "$NAME" \
             label="$INFO" \
             icon="$icon_result" \
             icon.font="sketchybar-app-font:Regular:16.0" \
             icon.drawing=on
fi
