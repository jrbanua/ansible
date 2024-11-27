#!/bin/bash

# Ensure sshpass is installed
if ! command -v sshpass &> /dev/null; then
    echo "sshpass is required but not installed. Install it with your package manager."
    exit 1
fi

# Check if the input file is provided and exists
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <machines_file>"
    exit 1
fi

MACHINES_FILE="$1"

if [ ! -f "$MACHINES_FILE" ]; then
    echo "File '$MACHINES_FILE' not found!"
    exit 1
fi

# Iterate through each line in the file
while IFS=' ' read -r USER_HOST PASSWORD; do
    if [ -z "$USER_HOST" ] || [ -z "$PASSWORD" ]; then
        echo "Skipping invalid line: $USER_HOST $PASSWORD"
        continue
    fi

    echo "Copying SSH key to $USER_HOST..."
    sshpass -p "$PASSWORD" ssh-copy-id -i ~/.ssh/ansible.pub "$USER_HOST"

    if [ $? -eq 0 ]; then
        echo "SSH key successfully copied to $USER_HOST."
    else
        echo "Failed to copy SSH key to $USER_HOST. Check your credentials or network connection."
    fi
done < "$MACHINES_FILE"