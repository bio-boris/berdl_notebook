#!/bin/bash
# Configure JupyterLab favorites for the user.
source /usr/local/bin/before-notebook.d/10-setup_env.sh

if [ ! -f "$JUPYTER_FAVORITES_FILE" ]; then
  SANITIZED_NB_USER_PATH="${NB_USER//\//_}"

  # A "here document" is used to safely write the multi-line JSON
  # string to the file, correctly expanding the shell variables.
  cat > "$JUPYTER_FAVORITES_FILE" << EOF
{
    // Favorites
    // @jlab-enhanced/favorites:favorites
    // Favorites settings.
    // **********************************

    // Favorites
    // The list of favorites.

    "favorites": [
      {
        "root": "/",
        "path": "${GLOBAL_SHARE_RELATIVE_TO_ROOT}",
        "contentType": "directory",
        "iconLabel": "ui-components:folder"
      },
      {
        "root": "/home",
        "path": "${SANITIZED_NB_USER_PATH}",
        "contentType": "directory",
        "iconLabel": "ui-components:folder"
      }
    ]
}
EOF
fi