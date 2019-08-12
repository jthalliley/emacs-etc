#!/bin/bash

if [ "$1" = "" ] ;then
    echo "You must supply a port."
    exit 1
fi

port=$1

lsof -i :${port}
