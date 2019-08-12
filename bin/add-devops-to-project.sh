#!/bin/bash
#-----------------------------------------------------------------------------
# Assumptions:
#   1. Repo has already been migrated from GitHub to BitBucket.
#-----------------------------------------------------------------------------
# Procedure:
#   1. Clone the BB repo.
#   2. Create "new-devops-toolset" branch.
#   3. Replace Jenkinsfile.
#   4. Update pom.xml with
#      a. properties
#      b. scm stanza
#   5. Try a build:  mvn clean package
#-----------------------------------------------------------------------------
jenkinsfile=~/Jenkinsfile-new-devops-toolset
dormantRepos=(
            "applicant-service" \
            "bureausmonthoftest" \
            "caps2-authws" \
            "caps2-batchjobs" \
            "caps2-bbook-autocheck" \
            "caps2-bureaus" \
            "caps2-cacauth" \
            "caps2-casemanagement" \
            "caps2-combinedbureaus" \
            "caps2-gpssid" \
            "caps2-lead" \
            "caps2-liquibase" \
            "caps2-routeonebatch" \
            "caps2-util" \
            "caps2-work-number-integration" \
            "credit-report-parsing-service" \
            "crm-test-suite" \
            "customerhub-service-client" \
            "dealer-interface" \
            "dealer-interfaces-domain" \
            "dealer-service" \
            "document-service" \
            "econtracting" \
            "paymentus-gateway" \
            "policy-service" \
            "rule-service" \
            "step3-capture-consumer" \
            "step3-capture-consumer-original" \
            "woodstox-cac" \
)

## "caps2-carletonsmartcalcs" \

inflightRepos="\
caps2-dealertrack \
caps2-domain \
caps2-inventory \
caps2-routeone \
caps2-scorecard-advance \
contract-interface \
contract-interface-domain \
inventory-ingest \
inventory-management \
inventory-service \
lead-service \
originations-ui \
scoring-engine \
vehicle-loan-application-service \
"

extraRepos=caps2

extraRepos2=contract-interfaces-domain

for repo in ${extraRepos2} ;do
    url=ssh://git@bitbucket.creditacceptance.com:7999/orig/${repo}.git
    git clone ${url}
    cd ${repo}
    git checkout master
    git checkout -b new-devops-toolset

    cp ${jenkinsfile} Jenkinsfile
    emacsclient pom.xml
done
