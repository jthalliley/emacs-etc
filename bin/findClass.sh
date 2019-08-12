#!/bin/bash

Help() {
    echo "Usage: findClass.sh topDir jarPat classPat"
    echo "where:"
    echo "   topDir   is the directory under which to find .jar files,"
    echo "   jarPat   is ls pattern for .jar files to be searched,"
    echo "   classPat is regex pattern for classes to be searched."
    exit 0
}

if [ "$1" == "" ] ;then
    Help
fi

topDir=$1
jarPat=$2
classPat=$3


jars=$(find $topDir -name ${jarPat}.jar)

for jar in $jars ;do
    searchResult=$(jar tvf $jar | egrep -i $classPat)

    if [ "$searchResult" != "" ] ;then
        echo "$jar"
        echo "   $searchResult"
    fi
done
