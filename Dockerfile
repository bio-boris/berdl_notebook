FROM ghcr.io/bio-boris/berdl_notebook-base:latest
# Python dependencies are updated in the base image
# and the base image is built from the pyspark-notebook image
# We can upgrade the base image to get the latest pyspark-notebook updates when we want spark 4.0

#TODO: MOVE INTO BASE IMAGE
# Remove /home/jovyan/


USER root
COPY ./configs/extensions/ /configs/extensions/
COPY ./configs/skel/* /etc/skel
COPY ./scripts/entrypoint.sh /entrypoint.sh
COPY ./configs/jupyter_docker_stacks_hooks /usr/local/bin/before-notebook.d
WORKDIR /home
ENTRYPOINT ["/entrypoint.sh"]
