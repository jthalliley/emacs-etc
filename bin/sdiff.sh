#!/bin/bash

scriptDir=$(dirname ${BASH_SOURCE[0]})
. ${scriptDir}/common-functions.sh

files=$(svn status -q | grep \\.java | cut -c 8-)
### files=$(svn diff -r PREV:HEAD --summarize | grep \\.java | cut -c 8-)
numFiles=$(echo $files | wc -w)

Log "$numFiles files changed ..."

for f in $files ;do
	tkdiff ${f}
done

