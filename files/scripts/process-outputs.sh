#!/bin/bash

# Generate outputs and upload data to object storage
if [[ ${JMETER_AUTOMATIC_OUTPUT_ENABLED^^} == "TRUE" ]] && [ -f "${JMETER_OUTPUT_PATH}/${JMETER_SUMMARY_FILENAME}" ]; then 
    # Sleep 3 seconds to ensure jmeter has been shutdown properly
    sleep 3
    echo "Compressing output folder into a tar file"
    tar -zcf ${JMETER_COMPRESSED_FILENAME} ${JMETER_OUTPUT_PATH}
    # Creating the prefix with the current time and the unixtime as unique indentifiers
    preffix="$(date +'%d%m%Y_%H%M%S')_$(($(date +'%s')))"
    mv ${JMETER_COMPRESSED_FILENAME} ${JMETER_OUTPUT_PATH}/${preffix}_${JMETER_COMPRESSED_FILENAME}
    # Check if minio is enabled to upload the image into the object storage
    if [[ ${MINIO_UPLOAD_ENABLED^^} == "TRUE" ]] && [[ ${MINIO_BUCKET_NAME^^} != "NONE" ]]; then 
        echo "Uploading the content into the object storage"
        mc cp ${JMETER_OUTPUT_PATH}/${preffix}_${JMETER_COMPRESSED_FILENAME} REPO/${MINIO_BUCKET_NAME}
    fi
fi