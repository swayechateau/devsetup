#!/bin/sh

# Run check if sudo

# Run check if brew already installed

# Define colors
GREEN='\033[0;32m'
NC='\033[0m' # No Color

read -p "Do you want to install this script? [Y/n] " answer
if [[ $answer == "" || $answer == "Y" || $answer == "y" ]]; then
    echo -e "${GREEN}Installing Homebrew...${NC}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Installation cancelled."
fi
