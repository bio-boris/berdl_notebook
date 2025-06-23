# This section is managed by the container's entrypoint script.
# It ensures proper environment loading for login shells.

# Source .bashrc for interactive shell configurations and core PATH.
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# Source user's custom profile for additional PATH or environment variables.
# Users can modify ~/.custom_profile directly for persistent customizations.
if [ -f ~/.custom_profile ]; then
    . ~/.custom_profile
fi
