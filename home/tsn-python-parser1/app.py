from flask import Flask, jsonify
import mysql.connector
import requests
from bs4 import BeautifulSoup
from dotenv import load_dotenv
import os

# Загружаем переменные окружения из .env файла
load_dotenv()

app = Flask(__name__)

# Параметры подключения к базе данных из .env файла
db_config = {
    'host': os.getenv('DB_HOST'),
    'user': os.getenv('DB_USERNAME'),
    'password': os.getenv('DB_PASSWORD'),
    'database': os.getenv('DB_DATABASE')
}

# Параметры для Telegram из .env файла
telegram_token = os.getenv('TELEGRAM_BOT_TOKEN')
chat_id = os.getenv('TELEGRAM_CHAT_ID')

# Функция отправки сообщений в Telegram
def send_telegram_message(message):
    url = f"https://api.telegram.org/bot{telegram_token}/sendMessage"
    payload = {
        "chat_id": chat_id,
        "text": message,
        "parse_mode": "HTML"
    }
    requests.post(url, data=payload)

# Парсинг новостей
def parse_and_insert():
    connection = mysql.connector.connect(**db_config)
    cursor = connection.cursor()

    url = "https://vsluh.ru/novosti/"
    response = requests.get(url)
    soup = BeautifulSoup(response.content, "html.parser")

    added_news = []

    for article in soup.find_all('article'):
        title = article.find('h2').text
        content = article.find('div', class_='content').text
        published_at = article.find('time')['datetime']
        image_url = article.find('img')['src']

        query = """
        INSERT INTO st_news (title, content, published_at, image_url, source, need_moderation)
        VALUES (%s, %s, %s, %s, %s, %s)
        """
        cursor.execute(query, (title, content, published_at, image_url, url, True))
        added_news.append(title)

    connection.commit()
    cursor.close()
    connection.close()

    if added_news:
        message = "Новые новости добавлены:\n" + "\n".join([f"- {title}" for title in added_news])
        send_telegram_message(message)
        return added_news
    else:
        send_telegram_message("Новых новостей нет.")
        return []

@app.route('/run-parser', methods=['GET'])
def run_parser():
    news = parse_and_insert()
    return jsonify({"status": "success", "added_news": news})

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)
