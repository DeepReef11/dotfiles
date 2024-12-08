#!/bin/bash

# Wait for Hyprland to be fully ready after resume
sleep 2
# exit
# # Get the primary monitor name
# PRIMARY_MONITOR=$(hyprctl monitors -j | jq -r '.[0].name')
# SECONDARY_MONITOR=$(hyprctl monitors -j | jq -r '.[1].name')

 
monitors_json=$(hyprctl monitors -j)
# workspaces_json=$(hyprctl workspaces -j)

monitors=($(echo $monitors_json | jq -r '. | sort_by(.x) | .[].name'))
# Get the primary monitor name
PRIMARY_MONITOR=${monitors[0]}
SECONDARY_MONITOR=${monitors[1]}

# Reset monitor configuration
if [ ! -z "$SECONDARY_MONITOR" ]; then
    # Reload the ML4W monitor configuration
    hyprctl reload

    # Ensure workspaces are on correct monitors (adjust numbers as needed)
    for i in {1..4}; do
        hyprctl dispatch moveworkspacetomonitor "$i" "$PRIMARY_MONITOR"
    done
    
    for i in {5..8}; do
        hyprctl dispatch moveworkspacetomonitor "$i" "$SECONDARY_MONITOR"
    done

        hyprctl dispatch moveworkspacetomonitor "9" "$PRIMARY_MONITOR"
        hyprctl dispatch moveworkspacetomonitor "10" "$SECONDARY_MONITOR"
fi
