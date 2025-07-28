FROM quay.io/jupyter/pyspark-notebook:spark-4.0.0
USER root


# PYTHON
RUN echo hello
COPY ./configs/environment.yaml /configs/environment.yaml
RUN mamba env update --file /configs/environment.yaml

# JUPYTER STACKS SPECIFIC
COPY ./configs/jupyter_docker_stacks_hooks/* /usr/local/bin/before-notebook.d/
COPY ./configs/skel/.bash_aliases /etc/skel

# SHELL



# MINIO


#COPY scripts/ /scripts/

# See https://github.com/jupyter/docker-stacks/tree/main/images/docker-stacks-foundation
#ENTRYPOINT ["tini", "-g", "--", "start.sh"]
#CMD start-notebook.py
