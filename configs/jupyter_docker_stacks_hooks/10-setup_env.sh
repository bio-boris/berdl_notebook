#!/bin/bash
# This script runs in the new users home directory.
# If we create new users in the container with `adduser`, they will automatically get skeleton files
set -x


if [ -z "$NB_UID" ]; then
  echo "NB_UID environment variable is not set."
  exit 1
fi

if [ -z "$NB_GID" ]; then
  echo "NB_GID environment variable is not set."
  exit 1
fi

if [ ! -d "$HOMEDIRECTORY" ]; then
  echo "Directory $HOMEDIRECTORY does not exist."
  exit 1
fi

#check GLOBAL_SHARE_RELATIVE_TO_ROOT
if [ -z "$GLOBAL_SHARE_RELATIVE_TO_ROOT" ]; then
  echo "GLOBAL_SHARE_RELATIVE_TO_ROOT environment variable is not set."
  exit 1
fi

HOMEDIRECTORY="/home/$NB_USER"
JUPYTER_FAVORITES_FILE="$HOMEDIRECTORY/.jupyter/lab/user-settings/@jlab-enhanced/favorites/favorites.jupyterlab-settings"
