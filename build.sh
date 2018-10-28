#!/bin/bash

project_dir=jmeter-helpers-lib
build_dir=${project_dir}/build/libs
output_dir=files/libs/lib
docker_image=apache-jmeter

# Remove all the files in build
if [[ -d "${build_dir}" ]]; then
	rm ${build_dir}/*
fi
	
# Build the fat Jar wit all the dependencies
gradle fatJar -p ${project_dir}

# Remove all the files in build
if [[ -d "${output_dir}" ]]; then
	rm ${output_dir}/${project_dir}*.jar
else
	mkdir -p ${output_dir}
fi

# Copy new version
cp ${build_dir}/*.jar ${output_dir}

# Create the Docker image
docker build -t ${docker_image}:latest . --rm
