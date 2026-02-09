#!/bin/bash

# File to store remote folders
REMOTE_FOLDERS_FILE="$HOME/.config/rclone/remote_folders.list"



# Function to sync existing remote folders without user input
sync_existing_folders() {
  if [[ -f "$REMOTE_FOLDERS_FILE" ]]; then
    while IFS=',' read -r remote_path local_path; do
      if [[ -n "$remote_path" && -n "$local_path" ]]; then
        echo "Automatically syncing existing folders: $remote_path to $local_path"
        rclone sync "$remote_path" "$local_path" --progress --log-file="$local_path/sync.log" --log-level=INFO --update
      fi
    done < "$REMOTE_FOLDERS_FILE"
  else
    echo "No existing remote folders file found. Proceeding to manual setup."
  fi
}

if [ ! -f "$REMOTE_FOLDERS_FILE" ]; then
  touch "$REMOTE_FOLDERS_FILE"
fi

# Function to sync and handle user input for new folders
sync_folder() {
  read -p "Enter the remote name (e.g., mega): " remote_name
  read -p "Enter the remote path (e.g., folder1/subolder1): " remote_path
  read -p "Enter the local path on home (e.g., Mega/folder1): " local_path

  # Create local directory if it does not exist
  mkdir -p "$HOME/$local_path"

  # Sync the folder with conflict resolution favoring local files
  rclone sync "$remote_name:/$remote_path" "$HOME/$local_path" --progress --log-level=INFO --update --log-file="$HOME/$local_path/sync.log"

# Append the new folder to the remote_folders file
  remote_path_entry="$remote_name:/$remote_path,$HOME/$local_path"
  if ! grep -Fxq "$remote_path_entry" "$REMOTE_FOLDERS_FILE"; then
    echo "$remote_path_entry" >> "$REMOTE_FOLDERS_FILE"
  fi
  echo "Sync complete for $remote_name:$remote_path to $local_path"
}

sync_existing_folders
# Main Loop for User Input
while true; do
  read -p "Do you want to sync another folder? (y/n): " choice
  if [[ "$choice" != "y" ]]; then
    break
  fi
  sync_folder
done
