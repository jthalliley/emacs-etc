#!/bin/bash
# Source this script

Log() {
    echo "#--> $1"
}

LOG() {
    echo "#================================= $1 ================================="
}

Info() {
    echo "... $1"
}

Error() {
    Log "ERROR: $1"
    exit 1
}

Pause() {
    prompt=$1
    expectedResponse=$2

    fullPrompt="${prompt} (type ${expectedResponse} or STOP) ? "

    while true ;do
        echo "----------------------"
        read -p "   ${fullPrompt}" response

        if [ "${response}" = "${expectedResponse}" ] ;then
            break
        elif [ "${response}" = "STOP" ] ;then
            Error "Stopped."
        fi
    done
}
