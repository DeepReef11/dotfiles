#!/bin/bash

# Define paths
STOW_DIR="$HOME/.dotfiles"
BACKUP_DIR="$HOME/.config-backup-$(date +%Y%m%d_%H%M%S)"
TARGET_DIR="$HOME"

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Run stow in simulate mode and capture the output
stow_output=$(cd "$STOW_DIR" && stow -n -v . 2>&1)

# Process stow output to find conflicts
echo "$stow_output" | grep "cannot stow" | while read -r line; do
    # Extract the target path from the stow message
    target_path=$(echo "$line" | grep -o "existing target [^ ]*" | cut -d' ' -f3)

    if [ -n "$target_path" ]; then
        # Convert target path to full path if it's not already
        if [[ "$target_path" != /* ]]; then
            target_path="$TARGET_DIR/$target_path"
        fi

        if [ -e "$target_path" ] && [ ! -L "$target_path" ]; then
            # Create the backup directory structure
            rel_path="${target_path#$TARGET_DIR/}"
            backup_path="$BACKUP_DIR/$rel_path"
            mkdir -p "$(dirname "$backup_path")"

            # Move the file/directory to backup
            echo "Moving $target_path to $backup_path"
            mv "$target_path" "$backup_path"
        fi
    fi
done

echo "Backup completed in $BACKUP_DIR"

