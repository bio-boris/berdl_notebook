#!/bin/bash
set -x

FAVORITES_FILE="/home/$NB_USER/.jupyter/favorites.json"

if [ ! -f "$FAVORITES_FILE" ]; then
  echo '{
    "favorites": [
      {
        "root": "/",
        "path": "'"${GLOBAL_SHARE_RELATIVE_TO_ROOT}"'",
        "contentType": "directory",
        "iconLabel": "ui-components:folder"
      },
      {
        "root": "/home",
        "path": "'"${NB_USER//\//_}"'",
        "contentType": "directory",
        "iconLabel": "ui-components:folder"
      }
    ]
  }' > "$FAVORITES_FILE"
fi