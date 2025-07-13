#!/bin/zsh

# Run this from your Obsidian vault's ROOT directory.
# `obslink` can be used as alias for this script. 
# !!! DANGER !!!
# This script will DELETE existing .obsidian folder/symlink
# and .obsidian.vimrc file/symlink in the current vault.
# BACK UP YOUR VAULT MANUALLY BEFORE RUNNING!
#
CENTRAL_CONFIG_PATH="$HOME/.config/.obsidian"

# Remove existing .obsidian (folder or symlink)
rm -rf .obsidian

# Create symlink for .obsidian folder
ln -s "$CENTRAL_CONFIG_PATH" .obsidian

# Remove existing .obsidian.vimrc (file or symlink)
rm -f .obsidian.vimrc

# Create symlink for .obsidian.vimrc file (if master exists)
if [ -f "$CENTRAL_CONFIG_PATH/.obsidian.vimrc" ]; then
    ln -s "$CENTRAL_CONFIG_PATH/.obsidian.vimrc" .obsidian.vimrc
fi

echo "Obsidian symlinks set. FULLY RESTART Obsidian now."
