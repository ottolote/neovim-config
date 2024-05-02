#!/bin/bash

REPO_NVIM_CONFIG=$(dirname "$(readlink --canonicalize "$0")")
LOCAL_NVIM_CONFIG=$(nvim --headless --cmd 'echo stdpath("config")' --cmd 'quit' 2>&1)

NVIM_FILES="lua init.lua"

# Create config dir if it doesn't exist
mkdir --parents "$LOCAL_NVIM_CONFIG"
echo "Creating symlinks from $REPO_NVIM_CONFIG to $LOCAL_NVIM_CONFIG"

for file in $NVIM_FILES; do
    if [ -e "$LOCAL_NVIM_CONFIG"/"$file" ]; then
        echo "Error: File $LOCAL_NVIM_CONFIG/$file already exists, no symlinks were created."
        exit 1
    fi
done

for file in $NVIM_FILES; do
    ln --symbolic --verbose "$REPO_NVIM_CONFIG"/"$file" "$LOCAL_NVIM_CONFIG"/"$file"
done


