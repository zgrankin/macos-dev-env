#!/bin/bash

# Determine the base directory of the script
BASE_DIR=$(dirname $(realpath $0))

# Paths to the source files relative to the script's base directory
ZSHRC_PATH="$BASE_DIR/../zshrc"
ALIASES_PATH="$BASE_DIR/../aliases"
ENV_SH_PATH="$BASE_DIR/../env.sh"

# Paths where the symlinks should point to
ZSHRC_TARGET_PATH="$HOME/.zshrc"
ALIASES_TARGET_PATH="$HOME/.aliases"
ENV_TARGET_PATH="$HOME/env.sh"

# Old file backup paths
ZSHRC_BACKUP_PATH="$HOME/.zshrc-backup"
ALIASES_BACKUP_PATH="$HOME/.aliases-backup"

# Function to handle backup and symlink creation
create_symlink() {
    local source_path=$1
    local target_path=$2
    local backup_path=$3

    # Backup existing regular files
    if [ ! -L "$target_path" ] && [ -f "$target_path" ] && [ $backup_path != "" ]; then
        mv "$target_path" "$backup_path"
        echo "Original $target_path has been copied to: $backup_path"
    fi

    # Create symlinks
    if [ -L "$target_path" ]; then
        echo "$target_path is already symlinked"
    elif [ -f "$source_path" ]; then
        ln -s "$source_path" "$target_path"
        echo "Symlinked $target_path to $source_path"
    fi
}

# Function to undo symlink creation and restore original files
undo_symlink() {
    local target_path=$1
    local backup_path=$2

    if [ -L "$target_path" ]; then
        rm "$target_path"
        echo "Removed symlink $target_path"
        if [ -f "$backup_path" ]; then
            mv "$backup_path" "$target_path"
            echo "Restored original file from $backup_path to $target_path"
        else
            echo "No backup file called $backup_path exists"
        fi
    else
        echo "No symlink exists at $target_path to undo."
    fi
}

# Check for the --undo flag
if [ "$1" == "--undo" ]; then
    undo_symlink "$ZSHRC_TARGET_PATH" "$ZSHRC_COPY_PATH"
    undo_symlink "$ALIASES_TARGET_PATH" "$ALIASES_COPY_PATH"
else
    # Create symlinks for the required files
    create_symlink "$ZSHRC_PATH" "$ZSHRC_TARGET_PATH" "$ZSHRC_BACKUP_PATH"
    create_symlink "$ALIASES_PATH" "$ALIASES_TARGET_PATH" "$ALIASES_BACKUP_PATH"
    create_symlink "$ENV_SH_PATH" "$ENV_TARGET_PATH"
fi

exit 0