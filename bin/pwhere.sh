#!/bin/bash

scriptDir=$(dirname ${BASH_SOURCE[0]})
. ${scriptDir}/common-functions.sh
. ${scriptDir}/deploy-functions.sh

pat="*${1}*"

dirs=$(echo $PATH | tr ":" "\n")

for d in $dirs ;do
    files=$(ls -1 $d/$pat 2>/dev/null)
    rc=$?
    if [[ $rc -eq 0 ]] ;then
        echo $files | tr " " "\n"
    fi
done
