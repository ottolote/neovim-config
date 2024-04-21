#!/bin/bash

LOCAL_NVIM_CONFIG=$(nvim --headless --cmd 'echo stdpath("config")' --cmd 'quit' 2>&1)

NVIM_FILES="lua init.vim init.lua"

# Check if any file is not a symlink and exit early if true
for file in $NVIM_FILES; do
    symlink="$LOCAL_NVIM_CONFIG/$file"
    if [ -e "$symlink" ] && [ ! -L "$symlink" ]; then
        echo "Error: $symlink exists and is not a symlink."
        exit 1
    fi
done

# Delete symlinks
for file in $NVIM_FILES; do
    symlink="$LOCAL_NVIM_CONFIG/$file"
    if [ -L "$symlink" ]; then
        echo "Removing symlink $symlink"
        unlink "$symlink"
    fi
done

echo "Neovim configuration symlinks removed"

