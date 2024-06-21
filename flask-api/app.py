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

@app.route('/rebuild', methods=['POST'])
def rebuild_container():
    try:
        data = request.json
        container_name = data['container_name']

        # Fetch the container
        container = client.containers.get(container_name)

        # Stop and remove the container
        container.stop()
        container.remove()

        # Rebuild the container
        image_name = container.attrs['Config']['Image']
        client.images.build(path=".", tag=image_name)

        # Start a new container
        client.containers.run(image_name, name=container_name, detach=True)

        return jsonify({
            'status': 'success',
            'message': f'Container {container_name} rebuilt and restarted successfully.',
            'code': 200
        }), 200
    except Exception as e:
        return jsonify({
            'status': 'error',
            'message': str(e),
            'code': 500
        }), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
