FROM quay.io/jupyter/pyspark-notebook:spark-4.0.0
USER root


# PYTHON
COPY configs /configs

RUN mamba env update --file /configs/environment.yaml

# SHELL
COPY configs/skel/.bash_aliases /etc/skel/
COPY configs/docker_statcks_hooks/* /usr/local/bin/before-notebook.d/

# MINIO


#COPY scripts/ /scripts/

# See https://github.com/jupyter/docker-stacks/tree/main/images/docker-stacks-foundation
#ENTRYPOINT ["tini", "-g", "--", "start.sh"]
#CMD start-notebook.py
