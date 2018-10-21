FROM openjdk:8-jdk-alpine

LABEL maintainer=jsa4000@gmail.com

ARG JMETER_VERSION="5.0"

ENV JMETER_HOME /opt/apache-jmeter-${JMETER_VERSION}
ENV JMETER_BIN  ${JMETER_HOME}/bin
ENV JMETER_MIRROR_HOST https://archive.apache.org/dist/jmeter
ENV JMETER_DOWNLOAD_URL ${JMETER_MIRROR_HOST}/binaries/apache-jmeter-${JMETER_VERSION}.tgz
ENV JMETER_PLUGINS_FOLDER ${JMETER_HOME}/lib/ext/
ENV JMETER_SOURCE /mnt/source
ENV JMETER_OUTPUT_PATH /tmp/jmeter

ENV JMETER_SERVER_ID 0
ENV JMETER_CLIENT_PORT 7000
ENV JMETER_SERVER_PORT 60000
ENV JMETER_SERVER_HOSTNAME NONE
ENV JMETER_RMI_SSL_DISABLED TRUE
ENV JMETER_SERVER_ENABLED FALSE
ENV JMETER_REMOTE_SERVERS NONE
ENV JMETER_CLOSE_REMOTE_SERVERS FALSE
ENV JMETER_SCRIPT_MODE FALSE
ENV JMETER_AUTOMATIC_OUTPUT_ENABLED TRUE

ENV JMETER_SUMMARY_FILENAME summary.csv
ENV JMETER_LOG_FILENAME logfile.log
ENV JMETER_DASHBOARD_PATHNAME dashboard
ENV JMETER_COMPRESSED_FILENAME summary-outputs.tar.gz

ENV JMETER_EXTRA_PARAMETERS NONE

ENV MINIO_UPLOAD_ENABLED FALSE
ENV MINIO_CLIENT_DOWNLOAD_URL https://dl.minio.io/client/mc/release/linux-amd64/mc
ENV MINIO_BUCKET_NAME NONE
ENV MC_HOSTS_REPO https://<Access-Key>:<Secret-Key>@<YOUR-S3-ENDPOINT>

RUN apk add --update tzdata curl unzip bash git \
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
COPY files/libs/* ${JMETER_PLUGINS_FOLDER}/

ENTRYPOINT ["entry-point.sh"]
