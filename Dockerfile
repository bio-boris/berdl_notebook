FROM ghcr.io/bio-boris/berdl_notebook-base:0.0.4
# Python and java dependencies are updated in the base image
# and the base image is built from the pyspark-notebook image
# We can upgrade the base image to get the latest pyspark-notebook updates when we want spark 4.0

COPY ./configs/extensions/ /configs/extensions/
COPY ./configs/skel/* /etc/skel
COPY ./scripts/entrypoint.sh /entrypoint.sh
COPY ./configs/jupyter_docker_stacks_hooks /usr/local/bin/before-notebook.d
COPY ./configs/ipython_startup  /configs/ipython_startup

WORKDIR /home

ENTRYPOINT ["/entrypoint.sh"]

