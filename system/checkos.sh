#!/bin/sh

# Check operating system
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    os="Linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    os="macOS"
elif [[ "$OSTYPE" == "cygwin" ]]; then
    os="Windows"
elif [[ "$OSTYPE" == "msys" ]]; then
    os="Windows"
else
    os="Unknown"
fi

echo $os
