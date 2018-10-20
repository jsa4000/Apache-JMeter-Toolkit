#!/bin/bash

echo "Running JMeter Script" 

echo "Test 01" 
jmeter-start.sh -t  Apache-JMeter-Toolkit/files/examples/Test01.linux.jmx -l file-output-01.csv -j test-01.log

echo "Test 02" 
jmeter-start.sh -t  Apache-JMeter-Toolkit/files/examples/Test01.linux.jmx -l file-output-02.csv -j test-02.log

echo "Test 03" 
jmeter-start.sh -t  Apache-JMeter-Toolkit/files/examples/Test01.linux.jmx -l file-output-03.csv -j test-03.log

echo "Test Finished" 