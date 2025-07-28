#!/bin/bash
# This script runs in the new users home directory.
# If we create new users in the container with `adduser`, they will automatically get skeleton files
set -x
cp -r --update=none /etc/skel/.??* /home/users/"$NB_USER"