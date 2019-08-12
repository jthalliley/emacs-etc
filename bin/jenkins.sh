#!/bin/bash

scriptDir=$(dirname ${BASH_SOURCE[0]})
source ${scriptDir}/jenkins-common.sh


#--------------------------------- M A I N ---------------------------------
isQA=0
isProd=0

if [ $# -gt 0 ] ;then
    case $1 in
        qa|QA)
            isQA=1
            ;;
        prod|PROD)
            isProd=1
            ;;
        *)
            echo "*** Expected QA or PROD."
            ;;
    esac
fi

if [[ $isQA -eq 1 ]] ;then
    Info "Running against QA"
    JENKINS_URL=$jenkinsQaUrl
elif [[ $isProd -eq 1 ]] ;then
    Info "Running against PROD"
    JENKINS_URL=$jenkinsProdUrl
fi

checkJavaVersion

origRepos=(\
"ancillary-service" \
"antivirus-scanner" \
"applicant-service" \
"caps2" \
"caps2-authws" \
"caps2-batchjobs" \
"caps2-bbook-autocheck" \
"caps2-bureaus" \
"caps2-cacauth" \
"caps2-carletonsmartcalcs" \
"caps2-casemanagement" \
"caps2-combinedbureaus" \
"caps2-dealertrack" \
"caps2-domain" \
"caps2-gpssid" \
"caps2-inventory" \
"caps2-lead" \
"caps2-routeone" \
"caps2-routeonebatch" \
"caps2-scorecard-advance" \
"caps2-util" \
"caps2-work-number-integration" \
"caps2-workthedeal" \
"caps2aggregator" \
"contract-interface" \
"contract-interfaces-domain" \
"credit-report-parsing-service" \
"customerhub-service-client" \
"dealer-interface" \
"dealer-interfaces-domain" \
"dealer-service" \
"document-service" \
"econtracting" \
"inventory-ingest" \
"inventory-management" \
"inventory-service" \
"lead-service" \
"originations-ui" \
"paymentus-gateway" \
"policy-service" \
"rule-service" \
"scoring-engine" \
"step3-capture-consumer" \
"vehicle-loan-application-service" \
"vehicle-value-guide-services" \
          )


### for name in $(getPluginNames); do
###     echo $name
### done

### listJobs Originations

### repos=${origRepos}
### createJobs
### updateJobs

### jenkinsCommand help install-plugin


### installPlugins

### jenkinsCommand help

### jenkinsCommand get-job orig-caps2

listPlugins
