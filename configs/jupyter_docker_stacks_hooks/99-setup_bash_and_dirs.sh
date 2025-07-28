#!/bin/bash
# This script runs in the new users home directory.
# If we create new users in the container with `adduser`, they will automatically get skeleton files
set -x
HOMEDIRECTORY="/home/$NB_USER"

if [ -z "$NB_UID" ]; then
  echo "NB_UID environment variable is not set."
  exit 1
fi

if [ ! -d "$DIR" ]; then
  echo "Directory $DIR does not exist."
  exit 1
fi

sudo chown "$NB_UID":"$NB_GID" "$HOMEDIRECTORY"
echo "Changed ownership of $DIR to UID:GID $NB_UID"


cp -r --update=none /etc/skel/.??* "$HOMEDIRECTORY"