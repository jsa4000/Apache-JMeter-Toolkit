#!/bin/bash

# WARNING: DO NOT INTRODUCE ANY MORE "ECHO" INBETWEEN, SINCE THE OUTPUT WITH THE FINAL JMETER ARGS WILL BE RETURNED. 

# Check jmeter automatic args for the output
if [[ ${JMETER_AUTOMATIC_OUTPUT_ENABLED^^} == "TRUE" ]]; then 
    # Remove args [-l,--logfile,-j,--jmeterlogfile]
    jmeter_args_array=($@)
    jmeter_clean_args=""
    expect_value=false
    for arg in "${jmeter_args_array[@]}"; do 
        if [[ ${expect_value} == true ]]; then continue; fi
        if [[ ${arg} == "-l" ]] || [[ ${arg} == "--logfile" ]] || [[ ${arg} == "-j" ]] || [[ ${arg} == "--jmeterlogfile" ]]; then 
            expect_value=true
        else
            expect_value=false
            jmeter_clean_args="${jmeter_clean_args} ${arg}"
        fi 
    done
    JMETER_ARGS="${jmeter_clean_args} -l ${JMETER_OUTPUT_PATH}/${JMETER_SUMMARY_FILENAME} -j ${JMETER_OUTPUT_PATH}/${JMETER_LOG_FILENAME}"
    echo ${JMETER_ARGS}
else
    echo $@
fi