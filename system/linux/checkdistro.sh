#!/bin/sh

# Check for lsb_release command
if command -v lsb_release > /dev/null; then
    distro=$(lsb_release -si)
else
    # Check for /etc/os-release file
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        distro=$NAME
    else
        distro="Unknown"
    fi
fi

echo $distro
