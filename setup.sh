#!/bin/bash

chmod +x "$0"

install_brew() {
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}


# Function to install Zsh
install_zsh() {
    echo "Installing Zsh..."
    if [ "$(uname)" == "Darwin" ]; then
        # macOS
        brew install zsh
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        # Linux
        if command -v apt-get &> /dev/null; then
            sudo apt-get update
            sudo apt-get install zsh
        elif command -v yum &> /dev/null; then
            sudo yum install zsh
        elif command -v pacman &> /dev/null; then
            sudo pacman -Syu zsh
        else
            echo "Unable to install Zsh. Unsupported Linux distribution."
            exit 1
        fi
    else
        echo "Unable to install Zsh. Unsupported operating system."
        exit 1
    fi
}

# Check if Zsh is installed
if ! command -v zsh &> /dev/null; then
    echo "Zsh is not installed. Installing..."
    install_zsh
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
