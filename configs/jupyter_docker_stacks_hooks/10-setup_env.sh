#!/bin/bash
set -x
HOME_DIRECTORY="/home/$NB_USER"

# Copy skeleton files if they don't exist
for f in .bash_aliases .custom_profile; do
    if [ ! -f "$HOME_DIRECTORY/$f" ]; then
        cp "/etc/skel/$f" "$HOME_DIRECTORY/$f"
    fi
done

# Define Jupyter paths
JUPYTER_DIR="$HOME_DIRECTORY/.jupyter"
FAVORITES_DIR="$JUPYTER_DIR/lab/user-settings/@jlab-enhanced/favorites"
AI_CONFIG_FILE="$JUPYTER_DIR/jupyter_ai_config.json"
FAVORITES_FILE="$FAVORITES_DIR/favorites.jupyterlab-settings"

# Create all needed directories at once
mkdir -p "$FAVORITES_DIR"

# Create AI config from a simple copy if it doesn't exist
if [ ! -f "$AI_CONFIG_FILE" ]; then
    cp /configs/extensions/jupyter_ai_config.json "$AI_CONFIG_FILE"
fi

# Create favorites config from a template if it doesn't exist
if [ ! -f "$FAVORITES_FILE" ]; then
    envsubst < /configs/extensions/favorites.jupyterlab-settings > "$FAVORITES_FILE"
fi

# Set ownership for the entire home directory at the very end
chown -R "$NB_USER" "$HOME_DIRECTORY"