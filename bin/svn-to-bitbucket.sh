#!/bin/bash

### http://pu-mtsvn-01/svn/ess/support-apps/Cheetah
export SVN_URL="http://pu-mtsvn-01/svn/ess/support-apps"
export BITBUCKET_URL="ssh://git@bitbucket.creditacceptance.com:7999"
export BITBUCKET_PROJECTKEY="ess"

### export SVN_REPO="caps2aggregator"

export AUTHORS_FILE=~/work/authors.txt


#MODULES=("activity-feed-web" "alerts-web" "bulk-user-creation-web" "delete-custom-user-data" "dportal-authentication" "dportal-user" "dportal-user-proxy" "mam-information-web" "navigaion-utility-bar-web" "report-data-rest-services" "resources-web" "session-timeout-jsp-override" "stats-web" "top-performer-web")


MODULES=("Cheetah")

MODULE_SVNLOCATION="ess/support-apps"

for mod in "${MODULES[@]}"
do
###    mkdir "${mod}"
###    cd "${mod}"

    ### mod=caps2aggregator
    git svn clone \
        --username=jhalliley \
        --no-minimize-url \
        --log-window-size=16000 \
        --ignore-paths="^[^/]+/(?:branches|tags)" \
        --authors-file=${AUTHORS_FILE} \
        --prefix=svn/  \
        ${SVN_URL}/${mod} \
        ${mod}


###        -r 29893:HEAD \
###        --ignore-paths="^[^/]+/(?:branches|tags)" \
###        --tags=tags \
###        --branches=branches \

exit
    git svn fetch

    cd $SVN_REPO

    cp -pR "${MODULE_SVNLOCATION}"/"${mod}"/* .

    git rm -rf liferay7-workspace

    rm -Rf liferay7-workspace

    git add --all

    git commit -m "svn --> git. First attempt for ${mod}"

    git remote add origin "${BITBUCKET_URL}"/"${BITBUCKET_PROJECTKEY}"/"${mod}"

    git push -u origin master


    cd /data/git-workspace/git-svn-converter-workspace/.

done
