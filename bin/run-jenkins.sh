#!/bin/bash

scriptDir=$(dirname ${BASH_SOURCE[0]})
source ${scriptDir}/common-functions.sh

source ~/bin/setup-java-1.8.sh

java -jar ~/Tools/jenkins/jenkins.war > /tmp/jenkins.log 2>&1 &
