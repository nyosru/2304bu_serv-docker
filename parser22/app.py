# from flask import Flask, request, jsonify
# import os
#
# app = Flask(__name__)
#
# @app.route('/qq', methods=['GET'])
# def p():
# 	return 'sdfsdfsdf'
#
# @app.route('/parse', methods=['POST'])
# def parse():
# #     data = request.json
# #     path = data.get('path')
# #
# #     if not path:
# #         return jsonify({'error': 'Path not provided'}), 400
#
#     # Здесь ваш код парсинга
# #     result = f"Parsing content at {path}"
#     result = f"Parsing content at"
#
#     return jsonify({'message': result})
#
# if __name__ == '__main__':
#     app.run(debug=True)

# from flask import Flask
# app = Flask(__name__)
# @app.route('/')
def hello_world():
    return 'Hello, World!'

if __name__ == '__main__':
    #app.run()
    hello_world()