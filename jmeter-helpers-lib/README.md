# JMeter Helpers Library

## Introduction

The idea with this library is to create a bundle with all the different libraries, helpers and programs that are going to be used with JMeter or by the container itself.

This way also unifies all the binaries that are going to be used such as mongodb, BCrypt, et.. and also it can provide facade classes so it would be easier to use later in JMeter.

The normal execution of the jar file print the following result on stdout

    java -jar jmeter-helpers-lib-all-1.0.0.jar
    This is not a standalone application.

However the library provides additional capabilities to create small programs to do particular tasks

    java -cp jmeter-helpers-lib-all-1.0.0.jar com.jmeter.apps.PartitionElection

## Helpers

- MongoHelper
- BCryptHelper
- DownloadHelper

## Applications

- PartitionElection
