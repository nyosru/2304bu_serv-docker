#!/bin/bash

echo "Adding virtual users..."

# Добавляем пользователей из файла /tmp/virtual_users.txt
while IFS= read -r line
do
    username=$(echo "$line" | cut -d':' -f1)
    password=$(echo "$line" | cut -d':' -f2)

    echo "Adding user: $username with password: $password"

    # Добавление пользователя с обычным текстовым паролем
    useradd -m "$username"
    echo "$username:$password" | chpasswd
done < /tmp/virtual_users.txt

echo "Finished adding virtual users."
