# Apache-JMeter-Toolkit

## Introduction

## Installation

- Build the Dockerfile

      docker build -t apache-jmeter . --rm

> JMeter version can be changed by using ``ARG JMETER_VERSION="5.0"`` defined on dockerfile

- Execute image to verify the build

      docker run -it apache-jmeter

  The output must be similar to the following

   ```txt
   Checking source /mnt/source/
   Jmeter Server enabled FALSE
   START Running Jmeter on Sat Oct 20 15:50:38 UTC 2018
   JVM_ARGS=-Xmn1356m -Xms5424m -Xmx5424m
   jmeter args=
   Oct 20, 2018 3:50:39 PM java.util.prefs.FileSystemPreferences$1 run
   INFO: Created user preferences directory.
   Incorrect Usage:Non-GUI runs require a test plan
         --?
               print command line options and exit
         -h, --help
               print usage information and exit
         -v, --version
   ...
   ```

- To clean up the images build

      docker image list
      docker image rm <id1> <id1> <id1> .. <idN> -f

> In linux just use the following command ``docker rmi $(docker images -q -f dangling=true)``

Following the **environment** variables available:

| Environment | Value |
| --- | --- |
| JMETER_HOME | /opt/apache-jmeter-${JMETER_VERSION} |
| JMETER_BIN | ${JMETER_HOME}/bin |
| MIRROR_HOST | https://archive.apache.org/dist/jmeter |
| JMETER_DOWNLOAD_URL | ${MIRROR_HOST}/binaries/apache-jmeter- ${JMETER_VERSION}.tgz |
| JMETER_PLUGINS_FOLDER | ${JMETER_HOME}/lib/ext/ |
| JMETER_SOURCE | /mnt/source/ or https://github.com/jsa4000/Apache-JMeter-Toolkit.git|

## Modes

### Manual

### JMeter Server

To execute a server use the following command. Basically it set ``JMETER_SERVER_ENABLED`` to true

      docker run -t -e JMETER_SERVER_ENABLED=true apache-jmeter

It can be passed some parameters to the executable

      docker run -t -e JMETER_SERVER_ENABLED=true -p 60000:60000 apache-jmeter -j file-server.log

Following the **environment** variables available:

| Environment | Value |
| --- | --- |
| JMETER_SERVER_PORT | 60000 |
| JMETER_CLIENT_PORT | 7000 |
| JMETER_RMI_SSL_DISABLED | TRUE |
| JMETER_SERVER_ENABLED | FALSE |

### JMeter Client

- Execute a Test Plan from volume

      docker run -t -v /D/DEVELOPMENT/Github/Apache-JMeter-Toolkit/files/examples:/mnt/source apache-jmeter -t /mnt/source/Test01.linux.jmx

- Execute a Test Plan from git source

      docker run -t -e JMETER_SOURCE=https://github.com/jsa4000/Apache-JMeter-Toolkit.git apache-jmeter -t Apache-JMeter-Toolkit/files/examples/Test01.linux.jmx

- Execute a distributed test among jmeter servers

      docker run -t -e JMETER_REMOTE_SERVERS=192.168.99.100:60000 -e JMETER_SOURCE=https://github.com/jsa4000/Apache-JMeter-Toolkit.git apache-jmeter -t Apache-JMeter-Toolkit/files/examples/Test01.linux.jmx

Following the **environment** variables available:

| Environment | Value |
| --- | --- |
| JMETER_CLIENT_PORT | 7000 |
| JMETER_RMI_SSL_DISABLED | TRUE |
| JMETER_REMOTE_SERVERS | NONE |

## Reference

- [JMeter - Make use of Docker](https://www.blazemeter.com/blog/make-use-of-docker-with-jmeter-learn-how)
- [JMeter - Distributed Testing with Docker](https://www.blazemeter.com/blog/jmeter-distributed-testing-with-docker)