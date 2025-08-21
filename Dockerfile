ARG BASE_TAG=base-latest
FROM ghcr.io/bio-boris/berdl_notebook_base:${BASE_TAG}
# Python and java dependencies are updated in the base image
# Don't forget to bump `berdl_notebook_base:0.0.X` in kube-spark-manager-image base version as well!
COPY ./configs/extensions/ /configs/extensions/
COPY ./configs/skel/* /etc/skel
COPY ./scripts/entrypoint.sh /entrypoint.sh
COPY ./configs/jupyter_docker_stacks_hooks /usr/locagitl/bin/before-notebook.d
COPY ./configs/ipython_startup  /configs/ipython_startup
WORKDIR /home
ENTRYPOINT ["/entrypoint.sh"]