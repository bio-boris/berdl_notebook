FROM bitnami/spark:4.0.0
USER root

ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini  /usr/local/bin/tini
RUN chmod +x /usr/local/bin/tini

# PYTHON
COPY configs /configs
RUN pip3 install --no-cache-dir -r /configs/requirements.txt

# SHELL
COPY configs/skel/ /etc/skel/

# MINIO


COPY scripts/ /scripts/
RUN chmod +x /scripts/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/tini", "--"]
CMD ["/scripts/entrypoint.sh"]
