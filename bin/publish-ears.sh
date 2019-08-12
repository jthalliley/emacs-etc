#!/bin/bash

scriptDir=$(dirname ${BASH_SOURCE[0]})
. ${scriptDir}/common-functions.sh

Help() {
    echo "Usage: publish-ears.sh"
    echo ""
    echo "Publishes .ear files to shared folder."
    exit 0
}

#-------------------------------------------------------
#   M A I N   S C R I P T
#-------------------------------------------------------
### if [ ! -d ${SHARED_VBOX_FOLDER} ] ;then
###     Error "Missing shared folder.  Currently SHARED_VBOX_FOLDER=${SHARED_VBOX_FOLDER}"
### fi

ears=$(find . -name *.ear)

earsCount=$(echo $ears | wc -w)

Log "Copying ${earsCount} .ear files..."

### for e in $ears ;do
###     Log "   $e"
###     cp -f ${e} ${SHARED_VBOX_FOLDER}/
### done

scp ${ears} jhalliley@10.10.115.85:/cygdrive/c/Deployables/

Log "Done."

### ls -l ${SHARED_VBOX_FOLDER}/*.ear
