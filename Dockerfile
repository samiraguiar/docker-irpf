FROM anapsix/alpine-java:8_server-jre

ARG PUID=1000
ARG PGID=1000

ENV IRPF_DEPENDENCIES="libxext libxrender libxtst libxi freetype"

RUN apk update \
 && apk add --no-cache $IRPF_DEPENDENCIES \
 && rm -rf /var/cache/apk/*

RUN addgroup -g ${PGID} irpf && \
    adduser -D -u ${PUID} -G irpf irpf

RUN wget http://downloadirpf.receita.fazenda.gov.br/irpf/2020/irpf/arquivos/IRPF2020-1.8.zip -O irpf2020.zip \
 && unzip irpf2020.zip -d /opt/ \
 && rm -f irpf2020.zip

USER irpf
ENV HOME /home/irpf
WORKDIR $HOME
CMD ["java", "-jar", "/opt/IRPF2020/irpf.jar"]
