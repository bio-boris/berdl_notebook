FROM bitnami/spark:4.0.0

ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

RUN pip3 install \
    'jupyterhub==4.*' \
    'notebook==7.*' \
    'jupyterlab' \
    'psutil' # psutil is a dependency for JupyterHub


# Copy the custom entrypoint script into the container.
COPY scripts/ /scripts/
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/tini", "--"]
CMD ["/scripts/entrypoint.sh"]
