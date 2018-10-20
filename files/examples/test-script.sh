#!/bin/bash

echo "----------------------------------" 
echo "--    Running JMeter Script     --" 
echo "----------------------------------" 
echo ""
echo "----------------------------------" 
echo "  Test 01" 
echo "----------------------------------" 
echo ""
jmeter-start.sh -t  Apache-JMeter-Toolkit/files/examples/Test01.linux.jmx -l file-output-01.csv -j test-01.log
echo ""
echo "----------------------------------" 
echo "  Test 02" 
echo "----------------------------------" 
echo ""
jmeter-start.sh -t  Apache-JMeter-Toolkit/files/examples/Test01.linux.jmx -l file-output-02.csv -j test-02.log
echo ""
echo "----------------------------------"
echo "  Test 03" 
echo "----------------------------------"
echo ""
jmeter-start.sh -t  Apache-JMeter-Toolkit/files/examples/Test01.linux.jmx -l file-output-03.csv -j test-03.log
echo ""
echo "----------------------------------"
echo "  Tests Finished" 
echo "----------------------------------" 