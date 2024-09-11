from flask import Flask, request, jsonify
import os

app = Flask(__name__)

@app.route('/parse', methods=['POST'])
def parse():
    data = request.json
    path = data.get('path')

    if not path:
        return jsonify({'error': 'Path not provided'}), 400

    # Здесь ваш код парсинга
    result = f"Parsing content at {path}"

    return jsonify({'message': result})

if __name__ == '__main__':
    app.run(debug=True)
 	jsonify({'message': '123'})
