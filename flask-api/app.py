from flask import Flask, request, jsonify
import docker

app = Flask(__name__)
client = docker.from_env()

@app.route('/restart', methods=['POST'])
def restart_container():
    container_name = request.json.get('container_name')
    if not container_name:
        return jsonify({'error': 'No container name provided'}), 400

    try:
        container = client.containers.get(container_name)
        container.restart()
        return jsonify({'status': 'success', 'message': f'Container {container_name} restarted'}), 200
    except docker.errors.NotFound:
        return jsonify({'error': 'Container not found'}), 404
    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
