#!/bin/sh

# Check for common package managers
if command -v apt-get > /dev/null; then
    pkg_manager="apt-get"
elif command -v dnf > /dev/null; then
    pkg_manager="dnf"
elif command -v yum > /dev/null; then
    pkg_manager="yum"
elif command -v zypper > /dev/null; then
    pkg_manager="zypper"
elif command -v pacman > /dev/null; then
    pkg_manager="pacman"
elif command -v brew > /dev/null; then
    pkg_manager="homebrew"
elif command -v choco > /dev/null; then
    pkg_manager="chocolatey"
else
    pkg_manager=null
fi

echo $pkg_manager
