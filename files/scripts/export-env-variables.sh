
# JMeter Global variables
export JMETER_SOURCE=/mnt/source
export JMETER_OUTPUT_PATH=/tmp/jmeter

# JMeter Server and Client variables
export JMETER_SERVER_ID=0
export JMETER_CLIENT_PORT=7000
export JMETER_SERVER_PORT=60000
export JMETER_SERVER_HOSTNAME=NONE
export JMETER_RMI_SSL_DISABLED=TRUE
export JMETER_SERVER_ENABLED=FALSE
export JMETER_REMOTE_SERVERS=NONE
export JMETER_CLOSE_REMOTE_SERVERS=FALSE
export JMETER_SCRIPT_MODE=FALSE
export JMETER_AUTOMATIC_OUTPUT_ENABLED=TRUE
export JMETER_PARAM_TYPE=J

# JMeter Output names
export JMETER_SUMMARY_FILENAME=summary.csv
export JMETER_LOG_FILENAME=logfile.log
export JMETER_DASHBOARD_PATHNAM=dashboard
export JMETER_COMPRESSED_FILENAME=summary-outputs.tar.gz

# Extra parameters not used. It can be exported any environment variable to the container.
export JMETER_EXTRA_PARAMETERS=NONE

# Minio specific variables
export MINIO_UPLOAD_ENABLED=FALSE
export MINIO_BUCKET_NAME=NONE
export MC_HOSTS_REPO=https://access-key:secret-key@s3-endpoint