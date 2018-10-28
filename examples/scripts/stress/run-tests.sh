#!/bin/bash

# -------------------------------------------------------------------------------------
# ENVIRONMENT VARIABLES REQUIRED 
# -------------------------------------------------------------------------------------
# - ENV_01 value_01
# - ENV_02 value_02
# -------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------
# VARIABLES
# -------------------------------------------------------------------------------------
# - threadCount: number of threads to be simulated
# - iterationCount: number of concurrent calls per thread
# -------------------------------------------------------------------------------------

# -------------------------------------------------------------------------------------
# NOTES: 
#   - All variables are passed using JMETER_PARAM_TYPE: possible value are 'G' or 'J'
#     This is for distributed testing so variables are also passed through the slaves.
# -------------------------------------------------------------------------------------

export JMETER_AUTOMATIC_OUTPUT_ENABLED=TRUE
output_folder=${JMETER_OUTPUT_PATH}
tests_folder="Apache-JMeter-Toolkit/examples/tests"

echo "----------------------------------" 
echo "--    Running JMeter Script     --" 
echo "----------------------------------" 

echo ""
echo "----------------------------------" 
echo "  Load Test                       " 
echo "----------------------------------" 
echo "  Threads = 10                    " 
echo "  Concurrency (per thread) = 10   " 
echo "----------------------------------" 
echo ""
threadCount=10
iterationCount=10
export JMETER_OUTPUT_PATH=${output_folder}/perf_test_${threadCount}_${iterationCount}
jmeter-start.sh -t  ${tests_folder}/jmeter-test-01.jmx \
                                    -${JMETER_PARAM_TYPE}threadCount=${threadCount} \
                                    -${JMETER_PARAM_TYPE}iterationCount=${iterationCount} \
                                    -${JMETER_PARAM_TYPE}outputPath=${JMETER_OUTPUT_PATH}
                                   
echo ""
echo "----------------------------------"
echo "  Tests Finished" 
echo "----------------------------------" 