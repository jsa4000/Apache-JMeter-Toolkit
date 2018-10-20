# Apache-JMeter-Toolkit

## Introduction

## Installation

- Build the Dockerfile

      docker build -t apache-jmeter . --rm

  > JMeter version can be changed by using ``ARG JMETER_VERSION="5.0"`` defined on dockerfile

- Execute image to verify the build

      docker run -it apache-jmeter

- The output must be similar to the following

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

- It can be used following commands to enter into the container using **bash**
  
  - Enter into the **shell** normally without doing any action

            docker run -it -e JMETER_SCRIPT_MODE=true apache-jmeter bash

  - Enter into the **shell** but specifying a **git** repository to start launching some tests inside the container

            docker run -it -e JMETER_SCRIPT_MODE=true -e JMETER_SOURCE=https://github.com/jsa4000/Apache-JMeter-Toolkit.git apache-jmeter bash

                  # Allows image to create automatically the outputs files
                  jmeter-start.sh -t Apache-JMeter-Toolkit/files/examples/Test01.linux.jmx

                  # Disable automatic output to allow specify custom output files with (-l,--logfile,-j,--jmeterlogfile)
                  export JMETER_AUTOMATIC_OUTPUT_ENABLED=FALSE
                  # Run following script and generate manually the outputs
                  jmeter-start.sh -t Apache-JMeter-Toolkit/files/examples/Test01.linux.jmx -l /tmp/jmeter/output1.csv -j /tmp/jmeter/output1.log

                  # Grant permissions to the script to run manually
                  chmod +x Apache-JMeter-Toolkit/files/examples/test-script.sh
                  # Launch the script
                  Apache-JMeter-Toolkit/files/examples/test-script.sh

- To clean up the images build

      docker image list
      docker image rm <id1> <id1> <id1> .. <idN> -f

      docker system prune

  > In linux just use the following command ``docker rmi $(docker images -q -f dangling=true)``

Following the **environment** variables that available when the **build** is performed:

> These environment variables depends on the ``JMETER_VERSION`` configured at build time, so it is **recommended** not change any of these variables

| Environment | Value |
| --- | --- |
| JMETER_HOME | /opt/apache-jmeter-${JMETER_VERSION} |
| JMETER_BIN | ${JMETER_HOME}/bin |
| JMETER_MIRROR_HOST | https://archive.apache.org/dist/jmeter |
| JMETER_DOWNLOAD_URL | ${MIRROR_HOST}/binaries/apache-jmeter- ${JMETER_VERSION}.tgz |
| JMETER_PLUGINS_FOLDER | ${JMETER_HOME}/lib/ext/ |

## Modes

### JMeter Server

To run a JMeter server use the following command. 

> Basically it must be set ``JMETER_SERVER_ENABLED`` to *true*

      docker run -t -e JMETER_SERVER_ENABLED=true apache-jmeter

It can be passed some **parameters** to the executable and bind **ports** to host

      docker run -t -e JMETER_SERVER_ENABLED=true -p 1099:1099 apache-jmeter -j file-server.log
      docker run -t -e JMETER_SERVER_ENABLED=true -p 1098:1099 apache-jmeter -j file-server.log

Following the **environment** variables that are available for JMeter server:

| Environment | Value |
| --- | --- |
| JMETER_SERVER_ID | 0 |
| JMETER_CLIENT_PORT | 7000 |
| JMETER_RMI_SSL_DISABLED | TRUE |
| JMETER_SERVER_ENABLED | FALSE |

### JMeter Client

- Execute a **Test Plan** from volume mount

      docker run -t -v /D/DEVELOPMENT/Github/Apache-JMeter-Toolkit/files/examples:/mnt/source apache-jmeter -t /mnt/source/Test01.linux.jmx

- Execute a **Test Plan** from **git source**

      docker run -t -e JMETER_SOURCE=https://github.com/jsa4000/Apache-JMeter-Toolkit.git apache-jmeter -t Apache-JMeter-Toolkit/files/examples/Test01.linux.jmx

- Execute a **script** from **git source**

      docker run -t -e JMETER_SCRIPT_MODE=TRUE -e JMETER_SOURCE=https://github.com/jsa4000/Apache-JMeter-Toolkit.git apache-jmeter Apache-JMeter-Toolkit/files/examples/test-script.sh

  > For scripts it is recommended to use ``jmeter-start.sh`` since it support for **distributed** testing using the same environment variables. An example could be seen at ``examples/test-script.sh``

- Execute a **distributed** test among jmeter servers

  > Use ``-e JMETER_CLOSE_REMOTE_SERVERS=TRUE`` to force to close the remote servers when the tests finish

      docker run -t -e JMETER_REMOTE_SERVERS=192.168.99.100:1098,192.168.99.100:1099 -e JMETER_SOURCE=https://github.com/jsa4000/Apache-JMeter-Toolkit.git apache-jmeter -t Apache-JMeter-Toolkit/files/examples/Test01.linux.jmx

      docker run -t -e JMETER_SCRIPT_MODE=TRUE -e JMETER_REMOTE_SERVERS=192.168.99.100:1098,192.168.99.100:1099 -e JMETER_SOURCE=https://github.com/jsa4000/Apache-JMeter-Toolkit.git apache-jmeter Apache-JMeter-Toolkit/files/examples/test-script.sh

Following the **environment** variables that are available for JMeter client:

| Environment | Value |
| --- | --- |
| JMETER_SOURCE | /mnt/source |
| JMETER_OUTPUT_PATH | /tmp/jmeter |
| JMETER_CLIENT_PORT | 7000 |
| JMETER_RMI_SSL_DISABLED | TRUE |
| JMETER_REMOTE_SERVERS | NONE |
| JMETER_CLOSE_REMOTE_SERVERS | FALSE |
| JMETER_SCRIPT_MODE | FALSE |
| JMETER_AUTOMATIC_OUTPUT_ENABLED | TRUE |

> The env variable ``JMETER_SOURCE`` can be a **local** folder (``/mnt/source``) or a **git** repository (https://github.com/jsa4000/Apache-JMeter-Toolkit.git)
> The env variable ``JMETER_AUTOMATIC_OUTPUT_ENABLED`` overwrites the entrances for outputs (-l,--logfile,-j,--jmeterlogfile) to allow automatization.

## Cloud Object Storage

- Run following command to run a **minio** container

      docker run --name minio01 -e MINIO_ACCESS_KEY=AKIAIOSFODNN7EXAMPLE -e MINIO_SECRET_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY -p 9000:9000 minio/minio server /data

- Credentials to access to minio object storage

  - **ACCESS_KEY** : AKIAIOSFODNN7EXAMPLE
  - **SECRET_KEY** : wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY

- Get minio client from the [repository](https://github.com/minio/mc)

      wget https://dl.minio.io/client/mc/release/linux-amd64/mc
      chmod +x mc

- Verify the client work successfully

      ./mc --help

- Create an environment variable for the connection inside the container

      export MC_HOSTS_REPO=http://AKIAIOSFODNN7EXAMPLE:wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY@192.168.99.100:9000

- List all the buckets in the account

      ./mc ls REPO

- Create a bucket (if not exist)

      ./mc mb REPO/test02  

  > Bucket must be created using **lowercase** names

- Copy a file into the bucket

      ./mc cp /tmp/jmeter/summary-outputs.tar.gz REPO/test02

### JMeter Integration

- Start **minio** server and create a bucket ``test02``

- Standalone tests using **Test Plan** and **minio**

      docker run -it -e MC_HOSTS_REPO=http://AKIAIOSFODNN7EXAMPLE:wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY@192.168.99.100:9000 -e MINIO_BUCKET_NAME=test02 -e JMETER_SOURCE=https://github.com/jsa4000/Apache-JMeter-Toolkit.git apache-jmeter -t Apache-JMeter-Toolkit/files/examples/Test01.linux.jmx

- Standalone tests using **scripts** and **minio**

      docker run -t -e MC_HOSTS_REPO=http://AKIAIOSFODNN7EXAMPLE:wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY@192.168.99.100:9000 -e MINIO_BUCKET_NAME=test02 -e JMETER_SCRIPT_MODE=TRUE -e JMETER_SOURCE=https://github.com/jsa4000/Apache-JMeter-Toolkit.git apache-jmeter Apache-JMeter-Toolkit/files/examples/test-script.sh

- Distributed tests using **scripts** and **minio**

      docker run -t -e JMETER_SERVER_ENABLED=true -p 1099:1099 apache-jmeter -j file-server.log
      docker run -t -e JMETER_SERVER_ENABLED=true -p 1098:1099 apache-jmeter -j file-server.log

       docker run -t -e MC_HOSTS_REPO=http://AKIAIOSFODNN7EXAMPLE:wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY@192.168.99.100:9000 -e MINIO_BUCKET_NAME=test02 -e JMETER_SCRIPT_MODE=TRUE -e JMETER_REMOTE_SERVERS=192.168.99.100:1098,192.168.99.100:1099 -e JMETER_SOURCE=https://github.com/jsa4000/Apache-JMeter-Toolkit.git apache-jmeter Apache-JMeter-Toolkit/files/examples/test-script.sh

## Reference

- [JMeter - Make use of Docker](https://www.blazemeter.com/blog/make-use-of-docker-with-jmeter-learn-how)
- [JMeter - Distributed Testing with Docker](https://www.blazemeter.com/blog/jmeter-distributed-testing-with-docker)