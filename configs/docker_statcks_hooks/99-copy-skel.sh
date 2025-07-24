#!/bin/bash
# Use cp with the -n flag to prevent overwriting files that might already exist.
echo "Copying skeleton files to ${HOME}..."
cp -r -n /config/skel/. "${HOME}/"