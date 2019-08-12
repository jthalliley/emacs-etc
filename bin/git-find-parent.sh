#!/bin/bash

scriptDir=$(dirname ${BASH_SOURCE[0]})
. ${scriptDir}/common-functions.sh
. ${scriptDir}/bitbucket-common.sh

childBranch=$1

projectId=ORIG
repo=caps2


branches=$(getBranchesPerRepo ${projectId} ${repo})

### branches=hotfix-firefox

thereIsAChildBranch=$(echo ${branches} | grep --count ${childBranch})

if [[ ${thereIsAChildBranch} -eq 0 ]] ;then
    echo "There is no branch named ${childBranch}."
    exit 1
fi

numFound=0
for branch in ${branches} ;do
    containsResults=$(git branch --contains ${branch} 2>/dev/null \
                          | sed ':a;N;$!ba;s/\n//g' \
                   )

    childBranchFound=$(echo ${containsResults} | grep --count ${childBranch})

    if [[ ${childBranchFound} -eq 1 ]] ;then
        parentBranch=$(echo ${containsResults} | sed "s/${childBranch}//g")
        echo "${parentBranch} is parent of ${childBranch}"
        numFound=$(expr $numFound + 1)
    fi
done

if [[ $numFound -eq 0 ]] ;then
    echo "Could not find parent of ${childBranch}."
    exit 1
fi

exit 0
