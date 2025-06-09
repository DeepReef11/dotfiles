#!/bin/bash

copy_no_history() {
  text="$@"
  current=$(wl-paste)
  wl-copy "$text"
  sleep 0.5
  cliphist delete-query "$text"
}

# Variables (customize these)
SEARCH_DIR="$HOME/nextcloud/Documents/token/"  # Directory to search for text files

# Check if search directory exists
if [ ! -d "$SEARCH_DIR" ]; then
    echo "Error: Directory '$SEARCH_DIR' does not exist."
    exit 1
fi

# Find all .txt files recursively and present in rofi
selected_file=$(find "$SEARCH_DIR" -type f -name "*.txt" | rofi -dmenu -i -p "Select a text file:")

# Check if a file was selected
if [ -n "$selected_file" ]; then
    # Check if file is readable
    if [ -r "$selected_file" ]; then
        # Copy file contents to clipboard
        # cat "$selected_file" | copy_no_history | echo
        copy_no_history $(cat "$selected_file")

        # Notify user (if notification system available)
        if command -v notify-send &> /dev/null; then
            notify-send "Text Copied" "$(basename "$selected_file") contents copied to clipboard"
        fi
    else
        echo "Error: Cannot read file '$selected_file'."
        exit 1
    fi
fi
