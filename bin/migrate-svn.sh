#!/bin/bash

CURRENT_SVN_REPO_DIR="/c01/svn_repository"
NEW_SVN_REPO_DIR="/c01/NEW_SVN_EXTRACTS.dir"
NEW_SVN_DUMP_DIR="/c01/NEW_SVN_DUMP.dir"
SVN_STARTING_REVISION_DATE="{2017-01-01}"
WHOLE_REPO_DUMP_FILE=${NEW_SVN_DUMP_DIR}/WHOLE-REPO.dumpfile

Log() {
    msg=$1
    echo "#-- $msg"
}

Error() {
    msg=$1
    echo "#***** $msg"
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
            [Yy] )
                break;;
            [Nn] )
                exit 1;;
            * )
                echo "   Please answer Y or N."
                ;;
        esac
    done
}

Help() {
    echo "Usage: migrate-svn.sh projectsFile"
    echo "where:"
    echo "   projectsFile is a file containing a list of svn projects to be migrated, one per line."
    echo ""
    echo "NOTE:  You must set the following env. vars. in the top of this script:"
    echo "       CURRENT_SVN_REPO_DIR, NEW_SVN_REPO_DIR, NEW_SVN_DUMP_DIR, SVN_STARTING_REVISION_DATE"
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

currentDate="{$(date +"%Y-%m-%d")}"
projects=$(cat ${projectsFile})

whichSvnadmin=$(which svnadmin)
svnadminVersion=$(svnadmin --version|awk '/^svnadmin/ {print $3}')

Log "Using svnadmin at ${whichSvnadmin} version ${svnadminVersion}."
Log "      which must be at version 1.8.x or higher."

Separator
Log "Transferring     from ${CURRENT_SVN_REPO_DIR}"
Log "                   to ${NEW_SVN_REPO_DIR}"
Log "   starting from date ${SVN_STARTING_REVISION_DATE}"
Log "                   to ${currentDate}"
Log "    using temp dir at ${NEW_SVN_DUMP_DIR}"
Log "which has this space available:"
df -h ${NEW_SVN_DUMP_DIR}
Separator

YesOrNo "Do you wish to continue with these settings"


Log "Dumping whole repo ..."
svnadmin dump ${CURRENT_SVN_REPO_DIR} --deltas --quiet --revision "${SVN_REVISION_DATE}:${currentDate}" > ${WHOLE_REPO_DUMP_FILE}
wholeRepoDumpFileSize=$(du -h ${WHOLE_REPO_DUMP_FILE} | awk '{print $1}')
Log "Done dumping whole repo.  Size is ${wholeRepoDumpFileSize}"
Separator

for svnProjectName in $projects ;do

    dumpfile=${NEW_SVN_DUMP_DIR}/${svnProjectName}.dumpfile

    Log "Dumping project ${svnProjectName} ..."
    svndumpfilter include ${svnProjectName} < ${WHOLE_REPO_DUMP_FILE} > ${dumpfile}
    rc=$?

    if [[ $rc -ne 0 ]] ;then
        Error "svnadmin dump failed for project ${svnProjectName}"
    fi
    Log "Done."

    Log "Loading project ${svnProjectName} ..."
    svnadmin load ${NEW_SVN_REPO_DIR} --parent-dir ${svnProjectName} --quiet < ${dumpfile}
    rc=$?

    if [[ $rc -ne 0 ]] ;then
        Error "svnadmin load failed for project ${svnProjectName}"
    fi
    Log "Done."

    rm -f ${dumpfile}
done

exit 0
