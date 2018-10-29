#!/bin/bash

# Generate outputs and upload data to object storage
if [[ ${JMETER_AUTOMATIC_OUTPUT_ENABLED^^} == "TRUE" ]] && [ -f "${JMETER_OUTPUT_PATH}/${JMETER_SUMMARY_FILENAME}" ]; then 
    # Sleep 3 seconds to ensure jmeter has been shutdown properly
    sleep 3
    echo "Compressing output folder into a tar file"
    tar -zcf ${JMETER_COMPRESSED_FILENAME} ${JMETER_OUTPUT_PATH}
    # Creating the prefix with the current time
    preffix="$(date +'%Y%m%dT%H%M%S')"
    mv ${JMETER_COMPRESSED_FILENAME} ${JMETER_OUTPUT_PATH}/${preffix}_${JMETER_COMPRESSED_FILENAME}
    # Check if minio is enabled to upload the image into the object storage
    if [[ ${MINIO_UPLOAD_ENABLED^^} == "TRUE" ]] && [[ ! -z ${MINIO_BUCKET_NAME} ]]; then 
        echo "Uploading the content into the object storage"
        mc cp ${JMETER_OUTPUT_PATH}/${preffix}_${JMETER_COMPRESSED_FILENAME} REPO/${MINIO_BUCKET_NAME}
    fi
fi