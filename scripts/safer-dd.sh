#!/bin/bash

# use ddi instead: yay -S ddi-bin

if [ $# -lt 2 ]; then
    echo "Usage: $0 <input_file> <output_device>"
    exit 1
fi

INPUT_FILE="$1"
OUTPUT_DEVICE="$2"

echo "WARNING: About to write $INPUT_FILE to $OUTPUT_DEVICE"
echo "This will PERMANENTLY ERASE all data on $OUTPUT_DEVICE"
echo ""
lsblk "$OUTPUT_DEVICE" 2>/dev/null || echo "Device info not available"
echo ""
echo "Type 'YES' to continue (case sensitive):"
read confirmation

if [ "$confirmation" = "YES" ]; then
    echo "Proceeding with dd operation..."
    sudo dd if="$INPUT_FILE" of="$OUTPUT_DEVICE" bs=4M status=progress
    echo "Operation completed"
else
    echo "Operation cancelled - confirmation not received"
fi
