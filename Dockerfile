FROM kalka/steamcmd:latest
LABEL maintainer="Kalka <k@kalka.io>"


ENV port=27015

ENV LD_LIBRARY_PATH=/opt/garrysmod/bin

USER root
COPY ./docker-entrypoint.sh /docker-entrypoint.sh

RUN apt-get update && \
    apt-get install -y libboost-all-dev:i386 && \
    apt-get clean

RUN chmod +x /docker-entrypoint.sh && \
    chown steam:steam /docker-entrypoint.sh && \
    chown -R steam:steam /opt

USER steam

RUN mkdir -p /opt/garrysmod

EXPOSE ${port}/udp

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["+gamemode", "sandbox", "+map", "gm_flatgrass"]
