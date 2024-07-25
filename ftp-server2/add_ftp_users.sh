#!/bin/bash

FTP_USERS_FILE=$1

if [ -f "$FTP_USERS_FILE" ]; then
  while IFS='|' read -r user pass; do
    echo "Creating user: $user"
    useradd -m -s /bin/false $user
    if [ $? -ne 0 ]; then
      echo "Error creating user: $user"
      continue
    fi
    echo -e "$pass\n$pass" | passwd $user
    if [ $? -ne 0 ]; then
      echo "Error setting password for user: $user"
    fi
  done < "$FTP_USERS_FILE"
else
  echo "FTP users file not found: $FTP_USERS_FILE"
  exit 1
fi
