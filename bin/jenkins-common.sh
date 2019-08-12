#!/bin/bash
#---------- Source this script

scriptDir=$(dirname ${BASH_SOURCE[0]})
source ${scriptDir}/common-functions.sh


jenkinsQaApiToken=11754ce85d5a12d28794421897c7d6bdf4
jenkinsProdApiToken=1174869d0fd799bcd1e327e331b83dedbb

jenkinsQaUrl=https://jenkinsqa.creditacceptance.com
jenkinsProdUrl=https://jenkins.creditacceptance.com


checkJavaVersion() {
    if [ -x ~/bin/setup-java-1.8.sh ] ;then
        source ~/bin/setup-java-1.8.sh
    fi

    version=$(java -version 2>&1 | awk '/^java version/ {version=$3 ; print substr(version, 2, length(version) - 2)}')

    if [[ "$version" =~ "1.8" ]] ;then
        echo "You're running Java ${version}.  Good."
    else
        echo "You're running Java ${version}, but must be 1.8."
        exit 2
    fi
}

setApiToken() {
    if [[ "$JENKINS_URL" =~ qa ]] ;then
        export JENKINS_API_TOKEN=$jenkinsQaApiToken
    else
        export JENKINS_API_TOKEN=$jenkinsProdApiToken
    fi
}

captureJenkinsCommandOutput() {
    command=${1}
    args=${2-}

    setApiToken
    result=$(java -jar ~/lib/jenkins-cli.jar -s ${JENKINS_URL} \
                  -auth ${JENKINS_USER_ID}:${JENKINS_API_TOKEN} \
                  $command $args)

    rc=$?
    if [ $rc -ne 0 ] ;then
        echo "jenkinsCommand failed, rc = $rc"
        exit $rc
    fi

    echo $result
}

jenkinsCommand() {
    command=${1}
    args=${2-}

    setApiToken
    java -jar ~/lib/jenkins-cli.jar -s ${JENKINS_URL} \
         -auth ${JENKINS_USER_ID}:${JENKINS_API_TOKEN} \
         $command $args

    rc=$?
    if [ $rc -ne 0 ] ;then
        echo "jenkinsCommand failed, rc = $rc"
        exit $rc
    fi
}

createJobs() {
    createOrUpdateJobs create
}

updateJobs() {
    createOrUpdateJobs update
}

createOrUpdateJobs() {
    operation=$1

    for thisRepo in "${repos[@]}" ;do
        echo "---------------------- repo: ${thisRepo}"
        export repo=${thisRepo}
        export BranchSourceList="\$BranchSourceList"
        cat input-job-config.xml | envsubst > final-config.xml

        job="orig-${thisRepo}"
        echo "---------------------- job:  $job"

        jenkinsCommand ${operation}-job ${job} < final-config.xml
    done
}

listJobs() {
    tab=$1

    jenkinsCommand list-jobs $tab
}

listPlugins() {
    jenkinsCommand list-plugins
}

getPluginNames() {
    setApiToken
    result=$(java -jar ~/lib/jenkins-cli.jar -s ${JENKINS_URL} \
                  -auth ${JENKINS_USER_ID}:${JENKINS_API_TOKEN} \
                  list-plugins \
                  | awk '{print $1}' | sort
          )

    echo $result
}

installPlugin() {
    plugin=$1

    jenkinsCommand install-plugin $plugin
}

installPlugins() {

    pluginsList=$(getPluginNames)

    JENKINS_URL=$jenkinsProdUrl
    dryRun=1
    count=0
    for plugin in $pluginsList ;do

        if [ $dryRun ] ;then
            echo "Would install $plugin"
        else
            jenkinsCommand install-plugin $plugin
        fi
        count=$(expr $count + 1)
    done

}
