#!/bin/bash

scriptDir=$(dirname ${BASH_SOURCE[0]})
. ${scriptDir}/common-functions.sh
. ${scriptDir}/bitbucket-common.sh

projectId=ORIG
repoNames="\
ancillary-service \
applicant-service \
bureausmonthoftest \
caps2 \
caps2-authws \
caps2-batchjobs \
caps2-bbook-autocheck \
caps2-bureaus \
caps2-cacauth \
caps2-carletonsmartcalcs \
caps2-casemanagement \
caps2-combinedbureaus \
caps2-dealertrack \
caps2-domain \
caps2-gpssid \
caps2-inventory \
caps2-lead \
caps2-routeone \
caps2-routeonebatch \
caps2-scorecard-advance \
caps2-util \
caps2-work-number-integration \
caps2-workthedeal \
caps2aggregator \
contract-interface \
contract-interfaces-domain \
credit-report-parsing-service \
customerhub-service-client \
dealer-interface \
dealer-interfaces-domain \
dealer-service \
document-service \
econtracting \
inventory-ingest \
inventory-management \
inventory-service \
lead-service \
paymentus-gateway \
policy-service \
rule-service \
scoring-engine \
step3-capture-consumer  \
vehicle-loan-application-service \
woodstox-cac\
"

for repo in $repoNames; do
    LOG $repo

    if [ ! -d $repo ] ;then
        gclone.sh $repo
    fi

    cd $repo

    git checkout master
    git pull

    git checkout automated-deploys ; rc=$?
    if [[ $rc -eq 0 ]] ;then
        git pull
        git merge master
        Pause "Done merging?" "YES"
    fi

    cd ..
done
