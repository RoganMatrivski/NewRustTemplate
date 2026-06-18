#!/usr/bin/env bash

# Add JSON: "postStartCommand": "chmod +x ./.devcontainer/onStart.sh; containerWorkspaceFolder=${containerWorkspaceFolder} ./.devcontainer/onStart.sh",

mount_folder="/mnt/docke    r-mnt";
sudo chown "$USER":"$USER" "$mount_folder";
link_folder="target";

for folder in $link_folder
do
  mkdir -p "$mount_folder/$folder"
  [ -z "$containerWorkspaceFolder" ] && exit 1
  rm -rf "${containerWorkspaceFolder}/$folder"
  ln -s $mount_folder/$folder ${containerWorkspaceFolder}/$folder
done
