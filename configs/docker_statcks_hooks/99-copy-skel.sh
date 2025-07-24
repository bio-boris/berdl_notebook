#!/bin/bash
# Use the cp with the -n flag to prevent overwriting files that might already exist.
echo "Copying skeleton files to ${HOME}..."
cp -r --update=none /config/skel/* "${HOME}git/"