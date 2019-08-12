#!/bin/bash

scriptDir=$(dirname ${BASH_SOURCE[0]})
. ${scriptDir}/common-functions.sh
. ${scriptDir}/bitbucket-common.sh

#-----------------------------------------------------------------------------
#  M A I N   S C R I P T
#-----------------------------------------------------------------------------
branchName=$1

if [ "$branchName" = "" ] ;then
    echo "Missing branchName."
    exit 1
fi

projectId=ORIG

repoNames=$(getReposPerProject ${projectId})

repoList=( ${repoNames} )
echo "There are ${#repoList[@]} ${projectId} repos."

### for repo in ${repoNames} ;do
###
###     LOG "${repo}"
###     verifyRepoContainsBranch ${projectId} ${repo} ${branch}
###
###     if [ ! -d ${repo} ] ; then
###         gclone.sh ${projectId} ${repo}
###     fi
###
###     cd ${repo}
###
###     git checkout ${branchName} > /dev/null 2>& 1
###     git pull                   > /dev/null 2>& 1
###
###     textFilesWithCRLF=$(find . -type f -exec grep -Iq . {} \; -print | \
###                             xargs file $f | grep CRLF | awk '{filenamePlusColon = $1 ; print substr(filenamePlusColon, 1, length(filenamePlusColon) - 1)}')
###     for f in ${textFilesWithCRLF} ;do
###         echo "$f"
###     done
###
###
###     cd ..
### done

for repo in ${repoNames} ;do

    verifyRepoContainsBranch ${projectId} ${repo} ${branchName}

done

exit 0
