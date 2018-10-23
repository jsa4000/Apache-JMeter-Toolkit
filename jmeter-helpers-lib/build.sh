#!/bin/bash

# Remove all the files in build
rm build/libs/*

# Build the fat Jar wit all the dependencies
gradle fatJar

# Remove previous versions
rm ../files/libs/lib/jmeter-helpers-lib*.jar

# Copy new version
cp build/libs/*.jar ../files/libs/lib
