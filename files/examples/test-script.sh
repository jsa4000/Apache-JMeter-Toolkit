#!/bin/bash

export JMETER_AUTOMATIC_OUTPUT_ENABLED=TRUE

echo "----------------------------------" 
echo "--    Running JMeter Script     --" 
echo "----------------------------------" 
echo ""
echo "----------------------------------" 
echo "  Test 01" 
echo "----------------------------------" 
echo ""
export JMETER_OUTPUT_PATH=/tmp/jmeter/test01
jmeter-start.sh -t  Apache-JMeter-Toolkit/files/examples/Test01.linux.jmx 
echo ""
echo "----------------------------------" 
echo "  Test 02" 
echo "----------------------------------" 
echo ""
export JMETER_OUTPUT_PATH=/tmp/jmeter/test02
jmeter-start.sh -t  Apache-JMeter-Toolkit/files/examples/Test01.linux.jmx 
echo ""
echo "----------------------------------"
echo "  Test 03" 
echo "----------------------------------"
echo ""
export JMETER_OUTPUT_PATH=/tmp/jmeter/test03
jmeter-start.sh -t  Apache-JMeter-Toolkit/files/examples/Test01.linux.jmx
echo ""
echo "----------------------------------"
echo "  Tests Finished" 
echo "----------------------------------" 