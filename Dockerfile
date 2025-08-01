FROM ghcr.io/bio-boris/berdl_notebook-base:latest
# Python dependencies are updated in the base image

USER root
COPY ./configs/skel/.bash_aliases /etc/skel
COPY ./scripts/entrypoint.sh /entrypoint.sh
WORKDIR /home
ENTRYPOINT ["/entrypoint.sh"]
