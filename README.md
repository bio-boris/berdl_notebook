# BERDL Notebook

* Sets up the user's environment
* Installs custom dependencies
  
# Dockerfile.base Image
* Use's the official JupyterHub base image
* Installs python dependencies
* This takes a long time to build, so it is pushed only on release.

# Dockerfile build
* Builds the Docker image using the base image and the notebook image
* Copies the necessary files and configurations
* 
