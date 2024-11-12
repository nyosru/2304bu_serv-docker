#!/bin/bash

set -e

DB_PATH="/etc/vsftpd/vsftpd_login.db"

if [ ! -f "$DB_PATH" ]; then
    touch $DB_PATH
    chmod 600 $DB_PATH
fi

echo "Adding virtual users..."

while read line; do
    username=`echo $line | cut -d':' -f1`
    password=`echo $line | cut -d':' -f2`

    if [ -z "$username" ] || [ -z "$password" ]; then
        continue
    fi

    echo "Adding user: $username with password: $password"
    echo $username >> /etc/vsftpd/virtual_users.txt
    echo $password >> /etc/vsftpd/virtual_users_passwd.txt
    echo -e "$username\n$password\n" | pam_password dbm -c >& /dev/null
done < /tmp/virtual_users.txt

echo "Virtual users added successfully."