FROM quay.io/jupyter/pyspark-notebook:spark-3.5.3
USER root

# PYTHON
RUN conda update -n base -c conda-forge conda
RUN rm /opt/conda/conda-meta/pinned
COPY ./configs/environment.yaml /configs/environment.yaml
RUN mamba env update --file /configs/environment.yaml

# Customizations
COPY ./configs/skel/.bash_aliases /etc/skel
# BASHRC
COPY ./configs/skel* /home/$NB_USER
