#!/bin/sh

if command -v brew >/dev/null 2>&1; then
    echo true
else
    echo false
fi
