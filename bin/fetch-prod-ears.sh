#!/bin/bash

EARS_DIR=~/Downloads

cd $EARS_DIR

svn checkout http://mivl05.cac.com/svn/caps2codemigration/Middleware/EAR

find $EARS_DIR -name *.ear -ls 2>/dev/null
