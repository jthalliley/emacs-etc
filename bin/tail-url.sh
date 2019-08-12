#!/bin/bash

url=$1

# Prompt for username
read -p "Username: " MYUSER

# prompt for password
read -s -p "Enter Password: " MYPASSWORD
echo ""


file=$(mktemp)
echo ${file}
trap 'rm $file' EXIT

(while sleep 1; do
        # shellcheck disable=SC2094
        curl -s -u ${MYUSER}:${MYPASSWORD} --fail -r "$(stat -c %s "$file")"- "$url" >> "$file"
done) &
pid=$!
trap 'kill $pid; rm $file' EXIT

tail -f "$file"
