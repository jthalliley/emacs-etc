#!/bin/bash

scriptDir=$(dirname ${BASH_SOURCE[0]})
. ${scriptDir}/common-functions.sh

branchName=$1

currentBranchName=$(git status | awk '/^On/ { print $3 }')

if [ "${branchName}" = "${currentBranchName}" ] ;then
    Error "You must switch to another branch before deleting it."
fi

Log "Deleting ${branchName} locally and on BitBucket..."

git branch -D $branchName && git push origin --delete $branchName

Log "Done."
