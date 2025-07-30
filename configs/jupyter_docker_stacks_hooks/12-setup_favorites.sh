#!/bin/bash
# Configure JupyterLab favorites for the user.
source .10-setup_env.sh

if [ ! -f "$FAVORITES_FILE" ]; then
  SANITIZED_NB_USER_PATH="${NB_USER//\//_}"

  # A "here document" is used to safely write the multi-line JSON
  # string to the file, correctly expanding the shell variables.
  cat > "$FAVORITES_FILE" << EOF
{
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