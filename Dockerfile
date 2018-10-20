FROM openjdk:8-jdk-alpine

LABEL maintainer=jsa4000@gmail.com

ARG JMETER_VERSION="5.0"

ENV JMETER_HOME /opt/apache-jmeter-${JMETER_VERSION}
ENV JMETER_BIN  ${JMETER_HOME}/bin
ENV JMETER_MIRROR_HOST https://archive.apache.org/dist/jmeter
ENV JMETER_DOWNLOAD_URL ${JMETER_MIRROR_HOST}/binaries/apache-jmeter-${JMETER_VERSION}.tgz
ENV JMETER_PLUGINS_FOLDER ${JMETER_HOME}/lib/ext/
ENV JMETER_SOURCE /mnt/source/

ENV JMETER_CLIENT_PORT 7000
ENV JMETER_RMI_SSL_DISABLED TRUE
ENV JMETER_SERVER_ENABLED FALSE
ENV JMETER_REMOTE_SERVERS NONE
ENV JMETER_CLOSE_REMOTE_SERVERS FALSE

RUN apk add --update tzdata curl unzip bash git \
	&& cp /usr/share/zoneinfo/UTC /etc/localtime \
	&& echo "UTC" > /etc/timezone \
	&& rm -rf /var/cache/apk/* \
	&& mkdir -p /tmp/dependencies  \
	&& curl -L --silent ${JMETER_DOWNLOAD_URL} > /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz \
	&& mkdir -p /opt  \
	&& tar -xzf /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz -C /opt  \
	&& rm -rf /tmp/dependencies
	
ENV PATH $PATH:$JMETER_BIN

EXPOSE 1099

WORKDIR ${JMETER_HOME}

COPY files/scripts/* $JMETER_BIN/
COPY files/libs/* ${JMETER_PLUGINS_FOLDER}/

ENTRYPOINT ["entry-point.sh"]
