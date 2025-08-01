FROM ghcr.io/bioboris/jupyterhub-berdl:base


USER root
COPY ./configs/skel/.bash_aliases /etc/skel
COPY ./scripts/entrypoint.sh /entrypoint.sh
WORKDIR /home
ENTRYPOINT ["entrypoint.sh"]
