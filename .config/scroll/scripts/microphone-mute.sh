#!/bin/bash

current_volume=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | awk '{print $2}' | awk '{printf "%.2f", $1}')

if [ "$current_volume" = "0.00" ]; then
    wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 1
    notify-send "Microphone" "Unmuted (100%)" -i audio-input-microphone
else
    wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 0
    notify-send "Microphone" "Muted (0%)" -i audio-input-microphone-muted
fi
