#!/bin/bash

filelist=$@

echo $filelist

. ~/bin/setup-java-1.8.sh

java -jar ~/lib/google-java-format-1.7-all-deps.jar \
     --replace --aosp \
     $filelist
