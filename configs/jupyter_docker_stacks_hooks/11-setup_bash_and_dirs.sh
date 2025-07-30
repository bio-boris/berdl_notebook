#!/bin/bash
# This script runs in the new users home directory.
# If we create new users in the container with `adduser`, they will automatically get skeleton files
source .10-setup_env.sh
set -x
sudo chown "$NB_UID":"$NB_GID" "$HOMEDIRECTORY"
echo "Changed ownership of $HOMEDIRECTORY to UID:GID $NB_UID"
cp -r --update=none /etc/skel/.??* "$HOMEDIRECTORY"