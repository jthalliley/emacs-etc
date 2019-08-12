#!/bin/bash

scriptDir=$(dirname ${BASH_SOURCE[0]})
. ${scriptDir}/common-functions.sh

whichRepo=$(awk '/url =/ {print $3} ' .git/config)

Log   "You are in ${whichRepo}."
Pause "Sure you want to delete all remote branches?" YES

REMOTE="origin"
git branch -r |  grep "^  ${REMOTE}/" | sed "s|^  ${REMOTE}/|:|" | grep -v "^:HEAD" | grep -v "^:master$" | xargs git push ${REMOTE}
