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
    # Sync new and updated files from remote to local, and then from local to remote
    rclone sync "$remote_path" "$local_path" --backup-dir="$local_path/backup" --progress --log-file="$local_path/sync.log" --log-level=INFO --update
    rclone sync "$local_path" "$remote_path" --backup-dir="$local_path/backup" --progress --log-file="$local_path/sync.log" --log-level=INFO --update
  fi
done < "$REMOTE_FOLDERS_FILE"

echo "All folders synced from remote."
