#!/bin/bash

totalMbToDelete=$(find ~/.m2/repository/ -atime +60 -iname '*.?ar' -ls \
                      | awk 'BEGIN {sum=0} {sum += $7} END {print sum / (1024 * 1024)}')


echo "Found ${totalMbToDelete} MB to delete;  now deleting..."

find ~/.m2/repository/ -atime +60 -iname '*.?ar' -exec rm {} \;

newTotalMbToDelete=$(find ~/.m2/repository/ -atime +60 -iname '*.?ar' -ls \
                         | awk 'BEGIN {sum=0} {sum += $7} END {print sum / (1024 * 1024)}')


echo "After delete, found ${newTotalMbToDelete} MB to delete. Done."
