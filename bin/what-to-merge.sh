#!/bin/bash

svn status -u

### check if ok to continue??

updatedFiles=$(svn update | awk '/^U / {print $2}')

#tomh temporary
updatedFiles=$(cat new-updates-files)

for f in $updatedFiles ;do
    secondRevision=$(svn log $f | awk 'BEGIN {count = 0} /^r[0-9]+/ {count = count + 1; if (count == 2) print $1}')

    simpleFileName=$(basename $f)

    svn diff -${secondRevision} $f > diffs-${simpleFileName}

    dos2unix diffs-${simpleFileName} > /dev/null 2>&1
done
