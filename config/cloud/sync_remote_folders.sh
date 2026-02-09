#!/bin/bash

# File that contains remote folders
REMOTE_FOLDERS_FILE="$HOME/.config/rclone/remote_folders.list"

# Check if the file exists
if [[ ! -f "$REMOTE_FOLDERS_FILE" ]]; then
  echo "Remote folders file not found!"
  exit 1
fi

# Read through each line in the remote folders file
while IFS=',' read -r remote_path local_path; do
  if [[ -n "$remote_path" && -n "$local_path" ]]; then
    echo "Syncing $remote_path to $local_path"
    # Sync each remote folder to the local counterpart
    rclone sync "$remote_path" "$local_path" --progress --log-file="$local_path/sync.log" --log-level=INFO --update
  fi
done < "$REMOTE_FOLDERS_FILE"

echo "All folders synced from remote."
