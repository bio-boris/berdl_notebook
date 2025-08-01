#!/bin/bash
# This script runs in the new users home directory.
# If we create new users in the container with `adduser`, they will automatically get skeleton files
set -x
HOME_DIRECTORY="/home/$NB_USER"
FAVORITES_FILE="$HOME_DIRECTORY/.jupyter/lab/user-settings/@jupyterlab/application-extension.jupyterlab-settings"

# Copy favorites from jovyan user
