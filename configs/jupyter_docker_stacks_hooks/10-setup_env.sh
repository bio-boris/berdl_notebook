#!/bin/bash
# This script runs in the new users home directory.
# If we create new users in the container with `adduser`, they will automatically get skeleton files
set -x
HOME_DIRECTORY="/home/$NB_USER"

# Copy bash aliases and custom profile to the new user's home directory, if they don't exist in the user's home directory.
if [ ! -f "$HOME_DIRECTORY/.bash_aliases" ]; then
    cp /etc/skel/.bash_aliases "$HOME_DIRECTORY/.bash_aliases"
    cp /etc/skel/.custom_profile "$HOME_DIRECTORY/.custom_profile"
    chown "$NB_USER" "$HOME_DIRECTORY/.bash_aliases" "$HOME_DIRECTORY/.custom_profile"
fi

# Copy Jupyter_ai_config.json to the new user's home directory, if it doesn't exist in the user's home directory.
if [ ! -f "$HOME_DIRECTORY/.jupyter/jupyter_ai_config.json" ]; then
    mkdir -p "$HOME_DIRECTORY/.jupyter"
    cp /configs/extensions/jupyter_ai_config.json "$HOME_DIRECTORY/.jupyter/jupyter_ai_config.json"
    chown -R "$NB_USER" "$HOME_DIRECTORY/.jupyter"
fi