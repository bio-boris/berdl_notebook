#!/bin/bash
# This script runs in the new users home directory.
# If we create new users in the container with `adduser`, they will automatically get skeleton files
set -x
HOME_DIRECTORY="/home/$NB_USER"

if [ ! -f "$HOME_DIRECTORY/.bash_aliases" ]; then
    cp /etc/skel/.bash_aliases "$HOME_DIRECTORY/.bash_aliases"
fi

if [ ! -f "$HOME_DIRECTORY/.custom_profile" ]; then
    cp /etc/skel/.custom_profile "$HOME_DIRECTORY/.custom_profile"
fi

# set perms of the .jupyter directory
if [ ! -d "$HOME_DIRECTORY/.jupyter" ]; then
    mkdir -p "$HOME_DIRECTORY/.jupyter"
fi

if [ ! -f "$HOME_DIRECTORY/.jupyter/jupyter_ai_config.json" ]; then
    install -o "$NB_USER" -D /configs/extensions/jupyter_ai_config.json "$HOME_DIRECTORY/.jupyter/jupyter_ai_config.json"
fi

# SETUP FAVORITES
FAVORITES_DIR="$HOME_DIRECTORY/.jupyter/lab/user-settings/@jlab-enhanced/favorites"
FAVORITES_FILE="$FAVORITES_DIR/favorites.jupyterlab-settings"
if [ ! -f "$FAVORITES_FILE" ]; then
    install -o "$NB_USER" -d /configs/extensions/favorites.jupyterlab-settings "$FAVORITES_FILE"
fi

# Recursively chown all files in the .jupyter directory to the user
chown -R "$NB_USER" "$HOME_DIRECTORY/.jupyter"