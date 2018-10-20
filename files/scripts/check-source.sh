#!/bin/bash

# Check for jmeter source    
echo "Checking source "${JMETER_SOURCE}                       
if [[ ${JMETER_SOURCE} == *".git" ]]; then         
    echo "Clonning from git source "${JMETER_SOURCE}   
    git clone ${JMETER_SOURCE}                     
fi                                               
