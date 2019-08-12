#!/bin/bash

envNameFrom() {
    fileName=$1

    result=$(echo ${fileName} | awk -F '-' '{ print $1 }')
    echo ${result}
}

settingsKindFrom() {
    fileName=$1

#   result=$(basename $filename .txt | awk -F '-' '{ print $2"-"$3"-"$4 }')

    result=server-start-params
    echo ${result}
}

splitFile() {
    fileName=$1

    envName=$(envNameFrom $fileName)
    settingsKind=$(settingsKindFrom $fileName)

    cat $fileName | awk -v envName="${envName}" -v settingsKind="${settingsKind}" '
    /^\#\-\-/ {
       appName = $2
       outFile = envName "/" envName "-" settingsKind "-" appName ".txt"
       print $0 > outFile
    }

    /^\-/ {
       print $0 >> outFile
    }
'

    echo "DONE $fileName"
}

showFile() {
    fileName=$1

    echo $fileName
    cat $fileName | awk '
{ print $0 }
'

}

filesToSplit=$(ls *.txt)

for f in $filesToSplit ;do

###    showFile $f
    splitFile $f
done
