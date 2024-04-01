#!/bin/bash

echo "user1:123123" | tee -a /home_as/ftp/virtual_users.txt
echo "user2:123123" | tee -a /home_as/ftp/virtual_users.txt

/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
