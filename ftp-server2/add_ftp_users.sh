#!/bin/bash

FTP_USERS_FILE=$1

if [ -f "$FTP_USERS_FILE" ]; then
  while IFS='|' read -r user pass; do
    echo "Creating user: $user"
    useradd -m -s /bin/false $user
    echo -e "$pass\n$pass" | passwd $user
  done < "$FTP_USERS_FILE"
else
  echo "FTP users file not found: $FTP_USERS_FILE"
  exit 1
fi


