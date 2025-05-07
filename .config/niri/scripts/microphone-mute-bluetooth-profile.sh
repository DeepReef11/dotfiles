#!/bin/bash

current_volume=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | awk '{print $2}' | awk '{printf "%.2f", $1}')

# Function to find Bluetooth card name
find_bluetooth_card() {
    # List all cards and find the one that contains "bluez"
    pactl list cards | grep -B 1 "bluez" | grep "Name:" | head -n 1 | awk '{print $2}'
}

# Get the Bluetooth card
bluetooth_card=$(find_bluetooth_card)

# Function to find available profiles for a card
find_available_profiles() {
    local card=$1
    local profile_type=$2  # "a2dp" or "headset"

    if [ "$profile_type" = "a2dp" ]; then
        # Try to find A2DP profile
        if pactl list cards | grep -A 30 "$card" | grep -q "a2dp-sink"; then
            echo "a2dp-sink"
        elif pactl list cards | grep -A 30 "$card" | grep -q "a2dp_sink"; then
            echo "a2dp_sink"
        else
            echo ""
        fi
    elif [ "$profile_type" = "headset" ]; then
        # Try to find headset profile
        if pactl list cards | grep -A 30 "$card" | grep -q "headset-head-unit"; then
            echo "headset-head-unit"
        elif pactl list cards | grep -A 30 "$card" | grep -q "headset_head_unit"; then
            echo "headset_head_unit"
        elif pactl list cards | grep -A 30 "$card" | grep -q "headset-head-unit-cvsd"; then
            echo "headset-head-unit-cvsd"
        elif pactl list cards | grep -A 30 "$card" | grep -q "handsfree_head_unit"; then
            echo "handsfree_head_unit"
        else
            echo ""
        fi
    fi
}

# Debug output
echo "Detected Bluetooth card: $bluetooth_card"

if [ "$current_volume" = "0.00" ]; then
    wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 1

    # Switch to headset profile if it's a Bluetooth device
    if [ -n "$bluetooth_card" ]; then
        headset_profile=$(find_available_profiles "$bluetooth_card" "headset")

        if [ -n "$headset_profile" ]; then
            pactl set-card-profile "$bluetooth_card" "$headset_profile"
            echo "Switched to $headset_profile profile"
        else
            echo "No suitable headset profile found"
        fi
    fi

    notify-send "Microphone" "Unmuted (100%)" -i audio-input-microphone
else
    wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 0

    # Switch to A2DP profile if it's a Bluetooth device
    if [ -n "$bluetooth_card" ]; then
        a2dp_profile=$(find_available_profiles "$bluetooth_card" "a2dp")

        if [ -n "$a2dp_profile" ]; then
            pactl set-card-profile "$bluetooth_card" "$a2dp_profile"
            echo "Switched to $a2dp_profile profile"
        else
            echo "No suitable A2DP profile found"
        fi
    fi

    notify-send "Microphone" "Muted (0%)" -i audio-input-microphone-muted
fi
