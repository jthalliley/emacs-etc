#!/bin/bash

#  Look through localhost_access_log.txt to find which versions of CI have been exercised recently.


cat logs/localhost_access_log.txt | grep 'GET /.contractInterface-'

cat logs/localhost_access_log.txt | awk  '/GET \/contractInterface-([0-9.]+)/ {print $1}'
