#!/bin/bash

scriptDir=$(dirname ${BASH_SOURCE[0]})
. ${scriptDir}/common-functions.sh

Help() {
    echo "Usage: jformat.sh [ file ... dir ... ] "
    echo "where:"
    echo "   file/dir is a source file/dir to be formatted."
    echo ""
    echo "Formats Java source via Eclipse."
    exit 0
}

#-------------------------------------------------------
#   M A I N   S C R I P T
#-------------------------------------------------------
whichDirsOrFiles=$*

if [ "$whichDirsOrFiles" = "" ] ;then
    Help
fi

useEclipse=0
export JAVA_HOME=~/Tools/jdk1.8.0_131
export PATH=$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$PATH

### eclipseConfigFile=~/eclipse-formatting-prefs.properties
eclipseConfigFile=~/CAPS-Eclipse-Project-Settings.xml
### eclipseConfigFile=~/google-java-formatting.xml

if [[ $useEclipse -eq 1 ]] ;then
    $ECLIPSE_HOME/eclipse \
        -debug \
        -application org.eclipse.jdt.core.JavaCodeFormatter \
        -config $eclipseConfigFile \
        ${whichDirsOrFiles} > /tmp/jformat.log 2>&1 \
        ; rc=$?
else
    for f in ${whichDirsOrFiles} ; do
        justFileName=$(basename ${f})
        formattedFile=/tmp/${justFileName}
        java -jar ~/lib/google-java-format-1.7-all-deps.jar ${f} > ${formattedFile}
###     mv ${formattedFile} $f
    done
fi

if [[ $rc -ne 0 ]] ;then
    Error "Formatter failed."
fi
