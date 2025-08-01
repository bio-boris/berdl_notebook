FROM ghcr.io/bio-boris/berdl_notebook-base:latest
# Python dependencies are updated in the base image
# and the base image is built from the pyspark-notebook image
# We can upgrade the base image to get the latest pyspark-notebook updates when we want spark 4.0

# Remove /home/jovyan/
RUN rm -rf /home/jovyan/

USER root
COPY ./configs/skel/.bash_aliases /etc/skel
COPY ./scripts/entrypoint.sh /entrypoint.sh
WORKDIR /home
ENTRYPOINT ["/entrypoint.sh"]
