#!/bin/bash

scriptDir=$(dirname ${BASH_SOURCE[0]})
. ${scriptDir}/common-functions.sh


SSN_FILE=ssns.txt
GET_HUB_URL="http://tu-mtcusthub-01:7013/customerHub/customer/getSsnId"
ADD_HUB_URL="http://tu-mtcusthub-01:7013/customerHub/customer/addSsn"

function parseSsnId() {
    jsonResult=$1

    parseSsnIdResult=$(echo $jsonResult | jq -r ".ssnId")
}

function getSsnId() {
    ssn=$1

    result=$(curl --silent  -X GET --header "Accept: application/json" $GET_HUB_URL/$ssn)
    rc=$?

    if [[ $rc -ne 0 ]] ;then
        echo "-- result = $result"
        result=$(curl --silent -X PUT \
                      --header 'Content-Type: application/json' --header 'Accept: application/json' --header 'Authorization: adminUser' \
                      -d "{\"callingSystem\": \"JTH\", \"ssn\": \"$ssn\"}" $ADD_HUB_URL)
        rc=$?
    fi

    if [[ $rc -ne 0 ]] ;then
        echo "-- result = $result"
        parseSsnIdResult=""

    else
        parseSsnId $result
    fi

    getSsnIdResult=$parseSsnIdResult
}

function unformattedSsn() {
    ssn=$1

    unformattedSsnResult=$(echo $ssn | tr --delete '-')
}

while read formattedSsn ;do

    unformattedSsn  $formattedSsn
    getSsnId        $unformattedSsnResult

    echo "-- $formattedSsn"

    if [ "$getSsnIdResult" = "" ] ;then
        echo "-- Could neither get nor add ssn: $formattedSsn"
    else
        echo "UPDATE steps.applicants         SET apc_ssnid  = $getSsnIdResult WHERE apc_ssn  = '$formattedSsn'"
        echo "UPDATE steps.applicants_history SET apch_ssnid = $getSsnIdResult WHERE apch_ssn = '$formattedSsn'"
    fi

done < $SSN_FILE
