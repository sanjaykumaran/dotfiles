#!/bin/bash

# Check if Zsh is installed
if ! command -v zsh &> /dev/null; then
    echo "Zsh is not installed. Please install Zsh and re-run this script."
    exit 1
fi

# Check if the default shell is already Zsh
if [ "$(basename "$SHELL")" != "zsh" ]; then
    # Change the default shell to Zsh
    chsh -s "$(command -v zsh)"

    if [ $? -ne 0 ]; then
        echo "Failed to switch default shell to Zsh. Please switch manually."
        exit 1
    fi

    echo "Default shell changed to Zsh. Please restart your terminal."
    exit 0
fi

# Refresh the shell to apply changes
exec zsh

# Create symbolic link for .zshrc
ln -sf ~/dotfile/.zshrc ~/.zshrc

