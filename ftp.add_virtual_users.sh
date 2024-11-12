#!/bin/bash

echo "Adding virtual users..."

# Добавляем пользователей из файла /tmp/virtual_users.txt
while IFS= read -r line
do
    username=$(echo "$line" | cut -d':' -f1)
    password=$(echo "$line" | cut -d':' -f2)

    # Проверяем, существует ли пользователь, чтобы избежать дублирования
    if id "$username" &>/dev/null; then
        echo "User $username already exists, skipping..."
    else
        echo "Adding user: $username with password: $password"
        useradd -m "$username" -p "$(openssl passwd -1 "$password")"
    fi
done < /tmp/virtual_users.txt

echo "Finished adding virtual users."
