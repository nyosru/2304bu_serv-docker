from flask import Flask, request, jsonify
import requests

app = Flask(__name__)

@app.route('/parse', methods=['POST'])
def parse():
    # Получаем путь для парсинга из запроса
    data = request.json
    host = data.get('host')
    if host == 'kudatumen':
        # Здесь вызываем функцию парсинга для kudatumen
        result = parse_kudatumen()
        return jsonify(result)
    else:
        return jsonify({"error": "Unknown host"}), 400

def parse_kudatumen():
    # Реализуйте здесь ваш парсинг
    # Например, делаем запрос к сайту и парсим его
    response = requests.get('https://kudatumen.ru/')
    # Обрабатываем ответ и возвращаем результат
    return {"status": "success", "data": response.text}

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
