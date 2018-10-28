FROM openjdk:8u181-jre-alpine

LABEL MAINTAINER=jsa4000@gmail.com

ARG JMETER_VERSION="5.0"

ENV JMETER_HOME /opt/apache-jmeter-${JMETER_VERSION}
ENV JMETER_BIN  ${JMETER_HOME}/bin
ENV JMETER_MIRROR_HOST https://archive.apache.org/dist/jmeter
ENV JMETER_DOWNLOAD_URL ${JMETER_MIRROR_HOST}/binaries/apache-jmeter-${JMETER_VERSION}.tgz
ENV JMETER_LIBRARIES_FOLDER ${JMETER_HOME}/lib
ENV JMETER_PLUGINS_FOLDER ${JMETER_HOME}/lib/ext
ENV MINIO_CLIENT_DOWNLOAD_URL https://dl.minio.io/client/mc/release/linux-amd64/mc

RUN apk add --update tzdata curl unzip bash git jq \
	&& cp /usr/share/zoneinfo/UTC /etc/localtime \
	&& echo "UTC" > /etc/timezone \
	&& rm -rf /var/cache/apk/* \
	&& mkdir -p /tmp/dependencies  \
	&& curl -L --silent ${JMETER_DOWNLOAD_URL} > /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz \
	&& curl -L --silent ${MINIO_CLIENT_DOWNLOAD_URL} > /usr/bin/mc && chmod +x /usr/bin/mc \
	&& mkdir -p /opt  \
	&& tar -xzf /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz -C /opt  \
	&& rm -rf /tmp/dependencies
	
ENV PATH $PATH:$JMETER_BIN

EXPOSE 1099

WORKDIR ${JMETER_HOME}

COPY files/scripts/* $JMETER_BIN/
COPY files/libs/lib/* ${JMETER_LIBRARIES_FOLDER}/
COPY files/libs/ext/* ${JMETER_PLUGINS_FOLDER}/

ENTRYPOINT ["entry-point.sh"]
