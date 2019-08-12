#!/bin/bash

CURRENT_SVN_REPO_DIR="/c01/svn_repository"
### NEW_GIT_REPOS_DIR="/c01/NEW_GIT_REPOS.dir"
NEW_GIT_REPOS_DIR="GIT_REPOS"
SVN_URL=http://mivl05.cac.com/svn

Log() {
    msg=$1
    echo "#-- $msg"
}

Error() {
    msg=$1
    echo "# ***ERROR*** $msg"
    exit 1
}

Separator() {
    echo "--------------------------------------------"
}

YesOrNo() {
    promptMsg=$1

    while true ;do
        read -p "${promptMsg}? (Y/N) " yesOrNo
        case "$yesOrNo" in
            [Yy])
                break
                ;;
            [Nn])
                exit 1
                ;;
            *)
                echo "   Please answer Y or N."
                ;;
        esac
    done
}

Help() {
    echo "Usage: $0 projectsFile"
    echo "where:"
    echo "   projectsFile is a file containing a list of svn projects to be migrated, one per line."
    echo ""
    echo "NOTE:  You must set the following env. vars. in the top of this script:"
    echo "       CURRENT_SVN_REPO_DIR, NEW_GIT_REPOS_DIR"
    exit 0
}

#-------------------------------------------------------
#   M A I N   S C R I P T
#-------------------------------------------------------
projectsFile=$1

if [ "${projectsFile}" = "" ] ;then
    Help
fi

if [ ! -e "${projectsFile}" ] ;then
    Error "No such file: ${projectsFile}"
fi

projects=$(cat ${projectsFile})

whichGit=$(which git)

if [[ "$whichGit" = "" ]] ;then
    Error "Could not find git."
fi
Log "Using git at ${whichGit}"

Separator
## Log "Transferring from ${CURRENT_SVN_REPO_DIR}"
Log "Transferring from ${SVN_URL}"
Log "               to ${NEW_GIT_REPOS_DIR}"
Separator

YesOrNo "Do you wish to continue with these settings"

for svnProjectName in $projects ;do

    isNested=$(echo $svnProjectName | grep -c /)

    if [ $isNested ] ;then
        asProjectName=$(basename $svnProjectName)
    else
        asProjectName=$svnProjectName
    fi

    Log "Transferring project ${svnProjectName} as ${asProjectName} ..."
    time git svn clone --quiet --quiet --no-minimize-url --authors-file=authors.txt \
         --stdlayout --log-window-size=40000 \
         ${SVN_URL}/${svnProjectName}  ${NEW_GIT_REPOS_DIR}/${asProjectName}
    rc=$?

    if [[ $rc -ne 0 ]] ;then
        Log "***ERROR*** git svn clone failed for project ${svnProjectName}."
    fi
    Log "Done."

done

exit 0
