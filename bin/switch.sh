#!/bin/bash

cd ~/.m2

which=$1

if [ -f settings-${which}.xml ] ;then
    cp settings-${which}.xml          settings.xml
else
    echo ERROR: no version \"${which}\" for settings.xml.
fi

if [ -f settings-security-${which}.xml ] ;then
    cp settings-security-${which}.xml settings-security.xml
else
    echo ERROR: no version \"${which}\" for settings-security.xml.
fi
