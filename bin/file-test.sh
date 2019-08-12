#!/bin/bash
################################################################################
# # Module Name: ftp_put.sh
#
# MODIFICATION LOG
#  DATE    DEVELOPER    RB#/AT        VER           REASON FOR CHANGE
#========  ==========   ========      =========     ============================
#01/11/13  R NESTER                   1.0           Initial version.
################################################################################

MAX_WAIT_SECONDS=30

function waitForFile() {
    theFile=$1

    count=0
    while [ ! -e "$theFile" ] ;do
        sleep 1
        count=$(expr $count + 1)

        if [[ $count -gt $MAX_WAIT_SECONDS ]] ;then
            echo "*** $MAX_WAIT_SECONDS seconds reached. File not found: $theFile"
            break
        fi
    done

}

if [ "$1" = "" ]
then
  echo "Usage:  `basename $0` <filename> <dest>"
  exit
fi

SRC_FILE=`basename $1`

waitForFile $SRC_FILE

echo "Done."
