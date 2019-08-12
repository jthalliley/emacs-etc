#!/bin/bash

scriptDir=$(dirname ${BASH_SOURCE[0]})
. ${scriptDir}/common-functions.sh

Help() {
    echo "Usage: smerge.sh whichProject [ --dry-run ]"
    echo "where:"
    echo "   whichProject is the project name, e.g., caps2, caps2domain, etc.,"
    echo "   --dry-run    says don't actually merge, just show what would happen."
    exit 0
}


if [ "$1" = "" ] ;then
    Help
fi

whichProject=$1
dryRun="$2"

trunkDir=../${whichProject}-trunk

if [ ! -d $trunkDir ] ;then
    Error "Expected trunk at $trunkDir"
fi

pushd $trunkDir  > /dev/null 2>&1
svn update
popd             > /dev/null 2>&1

svn merge ${dryRun} ${trunkDir}@HEAD .@HEAD
