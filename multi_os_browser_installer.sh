#!/bin/sh

os=$(./system/checkos.sh)
pkg_man=$(./system/checkpkgman.sh)
if [[ $answer == null ]]; then
    echo "No package manager detected. Exiting."
    exit 1
fi 


# Define colors
GREEN='\033[0;32m'
NC='\033[0m' # No Color

pkg_man_install() {
    for package in "$@"; do
        echo -e "${GREEN}Installing $package using $pkg_man...${NC}"
        $pkg_install_command= 
        $(./pkg_install.sh $pkg_man $package)
    done
}

# OS using PKGMAN
echo "Detected $os. Using $pkg_man for package installation."
read -p "Do you want to install a browser? [Y/n] " answer
if [[ $answer == "" || $answer == "Y" || $answer == "y" ]]; then
    read -p "Do you want to install Brave browser? [Y/n] " answer
    if [[ $answer == "" || $answer == "Y" || $answer == "y" ]]; then
        pkg_man_install brave-browser
    fi

    read -p "Do you want to install Opera browser? [Y/n] " answer
    if [[ $answer == "" || $answer == "Y" || $answer == "y" ]]; then
        read -p "Install Standard Opera? [Y/n] " answer
        if [[ $answer == "" || $answer == "Y" || $answer == "y" ]]; then
            pkg_man_install opera
        fi

        read -p "Install OperaGX? [Y/n] " answer
        if [[ $answer == "" || $answer == "Y" || $answer == "y" ]]; then
            pkg_man_install opera-gx
        fi
    fi

    read -p "Do you want to install Vivaldi browser? [Y/n] " answer
    if [[ $answer == "" || $answer == "Y" || $answer == "y" ]]; then
        read -p "Install Standard Vivaldi? [Y/n] " answer
        if [[ $answer == "" || $answer == "Y" || $answer == "y" ]]; then
            pkg_man_install vivaldi
        fi
    fi

    read -p "Do you want to install Tor browser? [Y/n] " answer
    if [[ $answer == "" || $answer == "Y" || $answer == "y" ]]; then
        pkg_man_install tor-browser
    fi

    read -p "Do you want to install Google Chrome browser? [Y/n] " answer
    if [[ $answer == "" || $answer == "Y" || $answer == "y" ]]; then
        read -p "Install Standard Google Chrome? [Y/n] " answer
        if [[ $answer == "" || $answer == "Y" || $answer == "y" ]]; then
            pkg_man_install google-chrome
        fi
    fi

    read -p "Do you want to install Microsoft Edge browser? [Y/n] " answer
    if [[ $answer == "" || $answer == "Y" || $answer == "y" ]]; then
        read -p "Install Standard Microsoft Edge? [Y/n] " answer
        if [[ $answer == "" || $answer == "Y" || $answer == "y" ]]; then
            pkg_man_install microsoft-edge
        fi
    fi

    read -p "Do you want to install Firefox browser? [Y/n] " answer
    if [[ $answer == "" || $answer == "Y" || $answer == "y" ]]; then
        read -p "Install Standard Firefox? [Y/n] " answer
        if [[ $answer == "" || $answer == "Y" || $answer == "y" ]]; then
            pkg_man_install firefox
        fi
    fi
fi