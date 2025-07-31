FROM quay.io/jupyter/pyspark-notebook:spark-3.5.3
USER root


# PYTHON
# Upgrade mamba's python environment to 3.12 when using non 4.0 version of this image.
# This line can be removed when the pyspark-notebook image is updated to 4.0
RUN conda update --prefix /opt/conda anaconda
COPY ./configs/environment.yaml /configs/environment.yaml
RUN mamba env update --file /configs/environment.yaml

# JUPYTER STACKS SPECIFIC
COPY ./configs/jupyter_docker_stacks_hooks/* /usr/local/bin/before-notebook.d/
COPY ./configs/skel/.bash_aliases /etc/skel

# Extensions / Favorites Related
ENV GLOBAL_SHARE_RELATIVE_TO_ROOT=global_share
COPY ./configs/extensions/jupyter_jupyter_ai_config.json /home/$NB_USER/.jupyter/jupyter_ai_config.json

