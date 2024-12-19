#!/bin/bash

# Path to your hosts file
hosts_file="/home/jrbanua/ansible/gather_specs_file/server.txt"

# Loop through each host in the file
while IFS= read -r host; do
    echo "Copying SSH key to $host"
    ssh-copy-id -i ~/.ssh/ansible.pub "$host"
done < "$hosts_file"