#!/bin/bash
# Configure JupyterLab favorites for the user.
source /usr/local/bin/before-notebook.d/10-setup_env.sh

if [ ! -f "$JUPYTER_FAVORITES_FILE" ]; then
  cat > "$JUPYTER_FAVORITES_FILE" << EOF
{
    "favorites": [
      {
        "root": "/",
        "path": "${GLOBAL_SHARE_RELATIVE_TO_ROOT}",
        "contentType": "directory",
        "iconLabel": "ui-components:folder",
        "name" : "Global Share"
      },
      {
        "root": "/home",
        "path": "${NB_USER}",
        "contentType": "directory",
        "iconLabel": "ui-components:folder",
        "name" : "${NB_USER}"
      }
    ]
}
EOF
chown "$NB_USER":"$NB_GID" "$JUPYTER_FAVORITES_FILE"
fi