#!/bin/bash

scriptDir=$(dirname ${BASH_SOURCE[0]})
. ${scriptDir}/common-functions.sh


Merge() {
    repo=$1
    if [ ! -d $repo ] ;then
        gclone.sh $repo
    fi

    cd $repo
    git checkout master
    git pull master
    git checkout bouncycastle-patch-fix
    git pull
    git merge master
}

Build() {
    export MAVEN_OPTS="-Dmaven.test.skip=true"
    mvn clean install
}

repos="caps2-inventory caps2 caps2-casemanagement caps2-dealertrack caps2-routeone econtracting"

for repo in $repos; do
    LOG $repo
    cd $repo

    ### Build
    git status

###    Pause 'Done' 'YES'
    cd ..
done
