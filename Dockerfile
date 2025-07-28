FROM quay.io/jupyter/pyspark-notebook:spark-4.0.0
USER root


# PYTHON
COPY ./configs/environment.yaml /configs/environment.yaml
RUN mamba env update --file /configs/environment.yaml

# JUPYTER STACKS SPECIFIC
COPY ./configs/jupyter_docker_stacks_hooks/* /usr/local/bin/before-notebook.d/
COPY ./configs/skel/.bash_aliases /etc/skel

# Extensions / Favorites Related
ENV GLOBAL_SHARE=/global_share
COPY ./extensions/jupyter_jupyter_ai_config.json /home/$NB_USER/.jupyter/jupyter_ai_config.json

