#!/bin/bash

# Check if folder argument is provided
if [ "$#" -lt 1 ]; then
    echo "Usage: ./popper.sh <folder> [additional arguments]"
    exit 1
fi

folder="$1"
shift 1  # Discard the first argument

# Execute the command
python3 ./popper.py "$folder" --debug --stats "$@"