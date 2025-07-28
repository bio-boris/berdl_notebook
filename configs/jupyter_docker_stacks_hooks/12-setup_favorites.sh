#!/bin/bash
set -x

FAVORITES_FILE="/home/$NB_USER/.jupyter/favorites.json"

if [ ! -f "$FAVORITES_FILE" ]; then
  echo '{
    "favorites": [
      {
        "root": "_",
        "path": "'${GLOBAL_SHARE//\//_}'",
        "contentType": "directory",
        "iconLabel": "ui-components:folder"
      },
      {
        "root": "_",
        "path": "/home/'"$NB_USER"'",
        "contentType": "directory",
        "iconLabel": "ui-components:folder"
      }
    ]
  }' > "$FAVORITES_FILE"
fi