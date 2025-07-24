import os
# NOTICE FOR BERDL_USERS: This will get overwritten on container restart. Do not modify this file #

c.ServerApp.base_url = os.environ.get('NB_PREFIX', '/')
c.ServerApp.log_level = os.environ.get('LOG_LEVEL', 'DEBUG').upper()
c.ServerApp.ip = '0.0.0.0'
c.ServerApp.port = 8888
c.ServerApp.open_browser = False
c.ServerApp.allow_root = False
#c.ServerApp.token = ''
#c.ServerApp.password = ''
#c.ServerApp.collaborative = True
#c.ServerApp.allow_origin = '*'
#c.ServerApp.allow_remote_access = True
# Sets the root directory that the JupyterLab server will expose to the user.
# JupyterLab should be started from this directory to ensure correct path handling.
# Note: In the entrypoint script, we will change directory to the user's home.
#c.ServerApp.root_dir = '/home/${JUPYTERHUB_USER}'
#c.ServerApp.disable_check_xsrf = True
