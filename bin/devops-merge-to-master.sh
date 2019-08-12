#!/bin/bash

scriptDir=$(dirname ${BASH_SOURCE[0]})
. ${scriptDir}/common-functions.sh

BROWSER=firefox

CreatePullRequest() {

    org=ORIG
    repo=$1
    branch=new-devops-toolset

    baseUrl="http://bitbucket.creditacceptance.com/projects/${org}/repos/${repo}"
    $BROWSER "${baseUrl}/pull-requests?create&targetBranch=refs%2Fheads%2Fmaster&sourceBranch=refs%2Fheads%2F${branch}"
}

#-- Original set...
repos="caps2\
 caps2-carletonsmartcalcs\
 caps2-dealertrack\
 caps2-domain\
 caps2-inventory\
 caps2-routeone\
 caps2-scorecard-advance\
 contract-interface\
 contract-interfaces-domain\
 inventory-ingest\
 inventory-management\
 inventory-service\
 originations-ui\
 scoring-engine\
 step3-capture-consumer\
 vehicle-loan-application-service\
"

#-- 2nd set...
repos="applicant-service\
 bureausmonthoftest\
 caps2aggregator\
 caps2-authws\
 caps2-batchjobs\
 caps2-bbook-autocheck\
 caps2-bureaus\
 caps2-cacauth\
 caps2-casemanagement\
 caps2-combinedbureaus\
 caps2-gpssid\
 caps2-lead\
 caps2-routeonebatch\
 caps2-util\
 caps2-work-number-integration\
 credit-report-parsing-service\
 customerhub-service-client\
 dealer-interface\
 dealer-interfaces-domain\
 dealer-service\
 document-service\
 econtracting\
 paymentus-gateway\
 policy-service\
 rule-service\
"

DoesDevopsBranchExist() {
    git checkout new-devops-toolset

    echo $?
}

CheckDevopsBranch() {

    for repo in $repos ;do
        LOG ${repo}
        cd ${repo}

        DoesDevopsBranchExist
        ### git checkout -b new-devops-toolset

        cd ..
    done

}

PrepareDevopsBranch() {
    for repo in $repos ;do

        LOG ${repo}
        ### git clone ssh://git@bitbucket.creditacceptance.com:7999/orig/${repo}.git
        cd ${repo}

        if [ "$(DoesDevopsBranchExist)" = "0" ] ;then
            git checkout -b new-devops-toolset

            cp $somewhere/Jenkinsfile .
        fi

        git status
        emacsclient pom.xml

        Pause "Ready to Push?" "YES"

        git commit -m "prep for new devops toolset" && git push

        cd ..
    done
}


PushDevopsBranch() {
    for repo in $repos ;do
        LOG ${repo}
        cd ${repo}

        git add pom.xml Jenkinsfile

        git commit -m "prep for new devops toolset" && git push

        cd ..
    done
}


MergeToMaster() {
    for repo in $repos ;do

        LOG ${repo}
        git clone ssh://git@bitbucket.creditacceptance.com:7999/orig/${repo}.git
        cd ${repo}

        git checkout master
        git pull

        git checkout new-devops-toolset
        git merge master

        Pause "Ready to Push?" "YES"

        git commit -m "merge from master" ; git push

        CreatePullRequest ${repo}

        cd ..
    done
}

PushToMaster() {
    for repo in $repos ;do

        LOG ${repo}
        cd ${repo}

        git checkout master
        git pull

        git add pom.xml Jenkinsfile
        git commit -m "update for new devops toolset"
        git push

        cd ..
    done
}

CheckStatus() {
    for repo in $repos ;do

        LOG ${repo}
        cd ${repo}

        git status

        cd ..
    done
}

NeedsJava8Compiler() {

    result=$(grep --count 'maven.compiler.source>1.8' pom.xml)

    echo $result
}


BuildMaster() {
    for repo in $repos ;do

        LOG ${repo}
        cd ${repo}

        git checkout master
        git pull

        needsJava8=$(NeedsJava8Compiler)

        if [ $needsJava8 = 1 ] ;then
            (  . ~/bin/setup-java-1.8.sh ; export MAVEN_OPTS="-Dmaven.test.skip=true" ; mvn -Dproject.build.name=$PROJECT_BUILD_NAME clean package )
        else
            (  . ~/bin/setup-java-1.7.sh ; export MAVEN_OPTS="-Dmaven.test.skip=true" ; mvn -Dproject.build.name=$PROJECT_BUILD_NAME clean package )
        fi

        cd ..
    done
}

WhichBranch() {
    for repo in $repos ;do

        LOG ${repo}
        cd ${repo}

        git status

        cd ..
    done
}

## PrepareDevopsBranch

## CheckDevopsBranch

## PushDevopsBranch

## MergeToMaster

## CheckMaster

## WhichBranch

##PushToMaster

## CheckStatus

BuildMaster
