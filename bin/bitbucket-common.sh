
#!/bin/bash
# Normally, source this script


bitbucketUrl="https://bitbucket.creditacceptance.com/rest/api/1.0/projects"
userPassword='jhalliley:EmacsIsDaBest!'

#-------------------------------------------------------
#-- This function doesn't parse the JSON correctly :(
#-------------------------------------------------------
doBranchQuery() {
    projectId=$1
    repo=$2
    branch=$3

    result=$(curl --silent --proxy $https_proxy --user "${userPassword}" \
                  -H "Content-type: application/json" -H "Accept: application/json" \
                  ${bitbucketUrl}/${projectId}/repos/${repo}/commits?until=${branch}&limit=1&start=0 \
                 | ppjson.sh \
                 | grep slug \
                 | awk '{ print substr($2, 2, length($2)-3) }' \
          )

    echo $result
}

verifyRepoContainsBranch() {
    projectId=$1
    repo=$2
    branch=$3

    branches=$(getBranchesPerRepo ${projectId} ${repo})
    branchList=( $branches )

    for branch in $branches ;do
        if [[ "${branch}" =~  "${branchName}" ]] ;then
            printf "%4s %-30s has branch %s\n" "${projectId}" "${repo}" "${branch}"
        fi
    done
}

getReposPerProject() {
    projectId=$1

    repoNames=$(curl --silent --proxy $https_proxy --user "${userPassword}" \
                     -H "Content-type: application/json" -H "Accept: application/json" \
                     ${bitbucketUrl}/${projectId}/repos/?limit=100 \
                    | ppjson.sh \
                    | grep slug \
                    | awk '{ print substr($2, 2, length($2)-3) }' \
                    | sort \
             )

    echo $repoNames
}

getBranchesPerRepo() {
    projectId=$1
    repo=$2

    branches=$(curl --silent --proxy $https_proxy --user "${userPassword}" \
                    -H "Content-type: application/json" -H "Accept: application/json" \
                    ${bitbucketUrl}/${projectId}/repos/${repo}/branches/?limit=100 \
                   | ppjson.sh \
                   | grep displayId \
                   | awk '{ print substr($2, 2, length($2)-3) }' \
                   | sort \
            )

    echo $branches
}

getGreatestTag() {
    result=$(git describe --tags $(git rev-list --tags --max-count=1))

    echo $result
}

CreatePR() {
    projectId=$1
    repo=$2
    branch=$3

    body="\
{\
    \"title\":\"Dummy README change to force version number update\",\
    \"description\":\"\",\
    \"fromRef\":{\
        \"id\":\"refs/heads/${branch}\",\
        \"repository\":{\
            \"slug\":\"${repo}\",\
            \"name\":null,\
            \"project\":{\"key\":\"${projectId}\"}\
        }\
    },\
    \"toRef\":{\
        \"id\":\"refs/heads/master\",\
        \"repository\":{\
            \"slug\":\"${repo}\",\
            \"name\":null,\
            \"project\":{\"key\":\"${projectId}\"}\
        }\
    },
    \"reviewers\":[\
       { \"user\": { \"name\": \"jcollins2\" } }\
    ]\
}"

    curl --silent --proxy $https_proxy \
         --user "${userPassword}" \
         -H "Content-Type: application/json" -H "Accept: application/json" \
         -X POST --data "$body" \
         ${bitbucketUrl}/${projectId}/repos/${repo}/pull-requests
}


###TESTING:  projectId=ORIG
###TESTING:  repoNames=$(getReposPerProject ${projectId})
###TESTING:  repoList=( ${repoNames} )
###TESTING:
###TESTING:  echo "There are ${#repoList[@]} ${projectId} repos."
###TESTING:
###TESTING:  for repo in ${repoNames} ;do
###TESTING:
###TESTING:      branches=$(getBranchesPerRepo ${repo})
###TESTING:      branchList=( ${branches} )
###TESTING:
###TESTING:      echo "There are ${#branchList[@]} branches in ${repo}."
###TESTING:
###TESTING:  done
###TESTING:
###TESTING:  exit

###TESTING:  CreatePR sam a pr-test
