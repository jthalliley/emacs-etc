#!/bin/bash

scriptDir=$(dirname ${BASH_SOURCE[0]})
. ${scriptDir}/common-functions.sh

Help() {
    echo "Usage:  gclone.sh projectId repo"
    echo "where:"
    echo "   projectId is the BitBucket project id, e.g., 'orig',"
    echo "   repo      is the BitBucket repository name, e.g., 'caps2'."
    exit 0
}

projectId=$1
repo=$2

if [ "$projectId" = "" ] ;then
    Help
fi
if [ "$repo" = "" ] ;then
    repo=$projectId
    projectId=orig
fi


git clone ssh://git@bitbucket.creditacceptance.com:7999/${projectId}/${repo}.git
