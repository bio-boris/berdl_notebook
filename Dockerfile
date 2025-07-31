FROM quay.io/jupyter/pyspark-notebook:spark-3.5.3
USER root


# PYTHON
RUN conda update -n base -c conda-forge conda
# Update to 3.12

COPY ./configs/environment.yaml /configs/environment.yaml
RUN mamba env update --file /configs/environment.yaml

# JUPYTER STACKS SPECIFIC
COPY ./configs/jupyter_docker_stacks_hooks/* /usr/local/bin/before-notebook.d/
COPY ./configs/skel/.bash_aliases /etc/skel

# Extensions / Favorites Related
ENV GLOBAL_SHARE_RELATIVE_TO_ROOT=global_share
COPY ./configs/extensions/jupyter_jupyter_ai_config.json /home/$NB_USER/.jupyter/jupyter_ai_config.json

