#!/bin/bash

scriptDir=$(dirname ${BASH_SOURCE[0]})
. ${scriptDir}/common-functions.sh

isUpdates=$1

if [[ "$isUpdates" != "" ]] ;then
    statusOptions=-u
else
    statusOptions=
fi


cd ~/work

dirs=$(ls)

for dir in $dirs ;do
    if [ -d $dir/.svn ] ;then
        cd $dir
        Log "  $dir :"
        svn status $statusOptions
        cd ..
    fi
done
