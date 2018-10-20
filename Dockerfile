FROM openjdk:8-jdk-alpine

LABEL maintainer=jsa4000@gmail.com

ARG JMETER_VERSION="5.0"

ENV JMETER_HOME /opt/apache-jmeter-${JMETER_VERSION}
ENV JMETER_BIN  ${JMETER_HOME}/bin
ENV MIRROR_HOST https://archive.apache.org/dist/jmeter
ENV JMETER_DOWNLOAD_URL ${MIRROR_HOST}/binaries/apache-jmeter-${JMETER_VERSION}.tgz
ENV JMETER_PLUGINS_FOLDER ${JMETER_HOME}/lib/ext/
ENV JMETER_SOURCE /mnt/source/

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

WORKDIR ${JMETER_HOME}

COPY files/scripts/* .
COPY files/libs/* ${JMETER_PLUGINS_FOLDER}/

CMD ["./launch.sh"]