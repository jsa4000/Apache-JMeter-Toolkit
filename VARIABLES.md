# | ENVIRONMENT | VARIABLES

| Environment | Value | Description |
| --- | --- | --- |
| JMETER_HOME | /opt/apache-jmeter- ${JMETER_VERSION} | |
| JMETER_BIN | ${JMETER_HOME}/bin | |
| JMETER_MIRROR_HOST | https://archive.apache.org/dist/jmeter | |
| JMETER_DOWNLOAD_URL | ${JMETER_MIRROR_HOST}/binaries/apache-jmeter- ${JMETER_VERSION}.tgz | |
| JMETER_LIBRARIES_FOLDER | ${JMETER_HOME}/lib | |
| JMETER_PLUGINS_FOLDER | ${JMETER_HOME}/lib/ext | |
| JMETER_SOURCE | /mnt/source | |
| JMETER_OUTPUT_PATH | /tmp/jmeter | |
| JMETER_SERVER_ID | 0 | |
| JMETER_CLIENT_PORT | 7000 | |
| JMETER_SERVER_PORT | 60000 | |
| JMETER_SERVER_HOSTNAME | NONE | |
| JMETER_RMI_SSL_DISABLED | TRUE | |
| JMETER_SERVER_ENABLED | FALSE | |
| JMETER_REMOTE_SERVERS | NONE | |
| JMETER_CLOSE_REMOTE_SERVERS | FALSE | |
| JMETER_SCRIPT_MODE | FALSE | |
| JMETER_AUTOMATIC_OUTPUT_ENABLED | TRUE | |
| JMETER_PARAM_TYPE | J | Possible values are ``G`` or ``J``. This variable should be used when parameters are passed through jmeter. Since jmeter differentiates **local** and **global** parameters for standalone and distributed executions. ie ``-{JMETER_PARAM_TYPE}maxIterations`` could be ``-GmaxIterations`` or ``-JmaxIterations`` |
| JMETER_SUMMARY_FILENAME | summary.csv | |
| JMETER_LOG_FILENAME | logfile.log | |
| JMETER_DASHBOARD_PATHNAME | dashboard |
| JMETER_COMPRESSED_FILENAME | summary-outputs.tar.gz | |
| JMETER_EXTRA_PARAMETERS | NONE | |
| MINIO_UPLOAD_ENABLED | FALSE | |
| MINIO_CLIENT_DOWNLOAD_URL | https://dl.minio.io/client/mc/release/linux-amd64/mc | |
| MINIO_BUCKET_NAME | NONE | |
| MC_HOSTS_REPO | https://access-key:secret-key@<3-endpoint | |