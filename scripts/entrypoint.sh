#!/bin/bash

# Exit if any command fails.
set -e

# Set default user/group for JupyterHub.
JUPYTERHUB_USER=${JUPYTERHUB_USER:-jovyan}
JUPYTERHUB_GROUP=${JUPYTERHUB_GROUP:-users}

echo "Configuring user: ${JUPYTERHUB_USER}"
echo "Configuring group: ${JUPYTERHUB_GROUP}"

# Create group if it doesn't exist.
if ! getent group "${JUPYTERHUB_GROUP}" >/dev/null; then
    echo "Creating group: ${JUPYTERHUB_GROUP}"
    groupadd "${JUPYTERHUB_GROUP}"
fi

# Create user if it doesn't exist, with home and shell.
if ! getent passwd "${JUPYTERHUB_USER}" >/dev/null; then
    echo "Creating user: ${JUPYTERHUB_USER}"
    useradd -m -s /bin/bash -g "${JUPYTERHUB_GROUP}" "${JUPYTERHUB_USER}"
fi

# Set correct permissions for home directory.
chown -R "${JUPYTERHUB_USER}:${JUPYTERHUB_GROUP}" /home/"${JUPYTERHUB_USER}"

# Create user's .jupyter configs directory.
USER_JUPYTER_CONFIG_DIR="/home/${JUPYTERHUB_USER}/.jupyter"
mkdir -p "${USER_JUPYTER_CONFIG_DIR}"
chown "${JUPYTERHUB_USER}:${JUPYTERHUB_GROUP}" "${USER_JUPYTER_CONFIG_DIR}"

# Copy JupyterLab configs file. (Dockerfile should copy this to /tmp)
cp /configs/jupyter_lab_config.py "${USER_JUPYTER_CONFIG_DIR}/jupyter_lab_config.py"
chown "${JUPYTERHUB_USER}:${JUPYTERHUB_GROUP}" "${USER_JUPYTER_CONFIG_DIR}/jupyter_lab_config.py"

# Switch to user and start JupyterLab.
echo "Switching to user ${JUPYTERHUB_USER} and starting JupyterLab..."
exec su - "${JUPYTERHUB_USER}" -c "cd /home/${JUPYTERHUB_USER} && jupyter lab"
