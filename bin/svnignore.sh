#!/bin/bash

Help() {
    echo "Usage: svnignore.sh whatDir whatToIgnore"
    echo "where:"
    echo "   whatDir      directory where thing to ignore lives,"
    echo "   whatToIgnore file/dir to be ignored."
    exit 0
}

whatDirItIsIn=$1
whatToIgnore=$2

if [ "$1" = "" ] ;then
    Help
fi


svn propset svn:ignore $whatToIgnore $whatDirItIsIn
