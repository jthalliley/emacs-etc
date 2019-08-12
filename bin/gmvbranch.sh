#!/bin/bash

scriptDir=$(dirname ${BASH_SOURCE[0]})
. ${scriptDir}/common-functions.sh

Help() {
    echo "Usage: gmvbranch.sh oldBranchName newBranchName"
    exit 0
}

oldBranchName=$1
newBranchName=$2

if [ "$2" = "" ] ;then
    Help
fi

if [ "${oldBranchName}" = "${newBranchName}" ] ;then
    Error "You must switch to another branch before deleting it."
fi

Log "Renaming ${oldBranchName} to ${newBranchName} locally and on BitBucket..."

git checkout       ${oldBranchName}
git branch -m      ${newBranchName}
git push origin   :${oldBranchName} ${newBranchName}
git push origin -u ${newBranchName}

Log "Done."
