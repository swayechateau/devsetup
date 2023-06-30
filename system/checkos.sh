#!/bin/sh

# Check operating system
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    os="linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    os="macos"
elif [[ "$OSTYPE" == "cygwin" ]]; then
    os="windows"
elif [[ "$OSTYPE" == "msys" ]]; then
    os="windows"
else
    os="unknown"
fi

echo $os
