import os
import sqlite3
from telethon import TelegramClient, events

# Получаем данные из переменных окружения
api_id = os.getenv('API_ID')
api_hash = os.getenv('API_HASH')
phone = os.getenv('PHONE_NUMBER')

# Инициализируем TelegramClient
client = TelegramClient('session_name', api_id, api_hash)

# Инициализируем базу данных SQLite
conn = sqlite3.connect('messages.db.sqlite')
cursor = conn.cursor()

# Создаем таблицу для хранения сообщений
cursor.execute('''
    CREATE TABLE IF NOT EXISTS messages (
        id INTEGER PRIMARY KEY,
        sender_id INTEGER,
        message TEXT,
        date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    )
''')
conn.commit()

# Обработчик новых сообщений
@client.on(events.NewMessage)
async def handler(event):
    sender = await event.get_sender()
    sender_id = sender.id
    message = event.message.message

    # Записываем сообщение в базу данных
    cursor.execute('''
        INSERT INTO messages (sender_id, message)
        VALUES (?, ?)
    ''', (sender_id, message))
    conn.commit()

    print(f"Сообщение от {sender_id} сохранено в БД: {message}")

# Основная функция для запуска клиента
async def main():
    await client.start(phone)
    await client.run_until_disconnected()

client.loop.run_until_complete(main())
