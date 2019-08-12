#!/bin/bash

echo "Show what would be synced..."
rsync --archive --delete --dry-run /usr/ /media/tomh/usr
