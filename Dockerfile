FROM quay.io/jupyter/pyspark-notebook:spark-3.5.3
USER root


# PYTHON
RUN conda update -n base -c conda-forge conda
RUN rm /opt/conda/conda-meta/pinned
COPY ./configs/environment.yaml /configs/environment.yaml
RUN mamba env update --file /configs/environment.yaml

# JUPYTER STACKS SPECIFIC
COPY ./configs/jupyter_docker_stacks_hooks/* /usr/local/bin/before-notebook.d/
COPY ./configs/skel/.bash_aliases /etc/skel

# Extensions / Favorites Related
COPY ./configs/extensions/jupyter_jupyter_ai_config.json /home/$NB_USER/.jupyter/jupyter_ai_config.json
COPY ./configs/extensions/favorites.json.json /home/$NB_USER/.jupyter/lab/user-settings/@jlab-enhanced/favorites/favorites.jupyterlab-settings

# BASHRC
COPY ./configs/skel* /home/$NB_USER