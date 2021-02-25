# this image is small enough and more powerfull than alpine
FROM phusion/baseimage:master

ARG INSTALLER_URL="https://downloadirpf.receita.fazenda.gov.br/irpf/2021/irpf/arquivos/IRPF2021Linux-x86_64v1.0.bin"
ARG DIR_NAME="IRPF2021"
ARG PUID=1000
ARG PGID=1000

ENV USER="irpf"
ENV IRPF_DEPENDENCIES="sudo libxtst6 libxrender1 libfontconfig1 libxi6"
# deps for the perl module used to extract files from the installer
ENV EXTRACT_PL_DEPENDENCIES="libmodern-perl-perl libcompress-raw-lzma-perl libterm-progressbar-perl libdata-dump-perl libfile-homedir-perl"
# enable anti-aliasing for Swing applications
ENV _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on"

RUN apt update \
 && apt-get install -y ${IRPF_DEPENDENCIES} \
 && apt-get install -y ${EXTRACT_PL_DEPENDENCIES} \
 && apt-get clean && rm -rf /var/lib/apt/lists/
ADD tools/unpack-install-jammer/extract.pl /tmp/extract.pl

# create an unprivileged  user for X11 socket
ENV HOME /home/${USER}
RUN groupadd ${USER} -g ${PGID} \
 && useradd -rm -d $HOME -s /bin/bash -g ${PGID} -G sudo -u ${PUID} ${USER}
# set the password for debugging purposes
RUN echo "${USER}:${USER}" | chpasswd

# Download and install the IRPF installer.
# Starting from version 2021, the Java runtime comes bundled inside the installer (but not the zip).
# However, running the installer doesn't seem to work on docker, so we use a 3rd-party tool to extract it.
ENV PREFIX="/opt"
# download in a separate command for better caching
RUN cd ${PREFIX}  \
 && curl -o irpf.bin "${INSTALLER_URL}" \
 && chmod +x irpf.bin

ENV IRPF_DIR="${PREFIX}/home/${USER}/ProgramasRFB/${DIR_NAME}"
# install to /opt to avoid polluting a possibly mounted home dir
RUN perl /tmp/extract.pl --quiet --prefix ${PREFIX} ${PREFIX}/irpf.bin \
 && chown -R ${PUID}:${PGID} ${IRPF_DIR} \
 && rm -f ${PREFIX}/irpf.bin /tmp/extract.pl

USER ${USER}
WORKDIR ${IRPF_DIR}
CMD ["bash", "exec.sh"]
