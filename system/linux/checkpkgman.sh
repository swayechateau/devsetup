#!/bin/sh

# Check for common package managers
if command -v apt > /dev/null; then
    pkg_manager="apt"
elif command -v yum > /dev/null; then
    pkg_manager="yum"
elif command -v dnf > /dev/null; then
    pkg_manager="dnf"
elif command -v zypper > /dev/null; then
    pkg_manager="zypper"
elif command -v pacman > /dev/null; then
    pkg_manager="pacman"
else
    pkg_manager="Unknown"
fi

echo $pkg_manager
