#!/bin/bash
monitors_json=$(hyprctl monitors -j)
PRIMARY_MONITOR=$(echo $monitors_json | jq -r '.[0].name')
SECONDARY_MONITOR=$(echo $monitors_json | jq -r 'if .[1].name then .[1].name else .[0].name end')

hyprctl keyword workspace 1,monitor:$PRIMARY_MONITOR
hyprctl keyword workspace 2,monitor:$PRIMARY_MONITOR
hyprctl keyword workspace 3,monitor:$PRIMARY_MONITOR
hyprctl keyword workspace 4,monitor:$PRIMARY_MONITOR
hyprctl keyword workspace 9,monitor:$PRIMARY_MONITOR
hyprctl keyword workspace 10,monitor:$PRIMARY_MONITOR

hyprctl keyword workspace 5,monitor:$SECONDARY_MONITOR
hyprctl keyword workspace 6,monitor:$SECONDARY_MONITOR
hyprctl keyword workspace 7,monitor:$SECONDARY_MONITOR
hyprctl keyword workspace 8,monitor:$SECONDARY_MONITOR
# Reset monitor configuration
# if [ ! -z "$SECONDARY_MONITOR" ]; then
    # Reload the ML4W monitor configuration
    # hyprctl reload

    # Ensure workspaces are on correct monitors (adjust numbers as needed)
    for i in {1..4}; do
        hyprctl dispatch moveworkspacetomonitor "$i" "$PRIMARY_MONITOR"
    done
    
    for i in {5..8}; do
        hyprctl dispatch moveworkspacetomonitor "$i" "$SECONDARY_MONITOR"
    done

        hyprctl dispatch moveworkspacetomonitor "9" "$PRIMARY_MONITOR"
        hyprctl dispatch moveworkspacetomonitor "10" "$PRIMARY_MONITOR"
# fi
