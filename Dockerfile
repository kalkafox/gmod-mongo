FROM kalka/steamcmd:latest
LABEL maintainer="Kalka <k@kalka.io>"


ENV port=27015

ENV LD_LIBRARY_PATH=/opt/garrysmod/bin

USER root
COPY ./docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh && \
    chown steam:steam /docker-entrypoint.sh

RUN apt-get update && \
    apt-get install libboost-all-dev:i386 && \
    apt-get clean

USER steam

VOLUME /opt/garrysmod

EXPOSE ${port}/udp

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["-game", "garrysmod", "+gamemode", "sandbox", "+map", "gm_flatgrass"]
