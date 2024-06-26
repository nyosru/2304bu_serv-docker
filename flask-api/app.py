from flask import Flask, request, jsonify
import docker

app = Flask(__name__)
client = docker.from_env()


@app.route('/full_update_crontab', methods=['POST'])
def full_update_crontab():
    try:
        data = request.get_json()
        container_name = data.get('container_name')
        new_crontab_content = data.get('crontab_content')

        if not container_name or not new_crontab_content:
            return jsonify({
                'status': 'error',
                'message': 'container_name and crontab_content are required.',
                'code': 400
            }), 400

        # Получаем контейнер по имени
        container = client.containers.get(container_name)

        # Сначала очищаем текущий crontab
        clear_command = container.exec_run(['crontab', '-r'])
        if clear_command.exit_code != 0 and "no crontab for" not in clear_command.output.decode('utf-8'):
            raise Exception("Failed to clear crontab.")

        # Создаем временный файл с новым содержимым crontab
        with open('/tmp/new_crontab', 'w') as f:
            f.write(new_crontab_content)

        # Копируем временный файл в контейнер
        with open('/tmp/new_crontab', 'rb') as f:
            container.put_archive('/tmp/', f.read())

        # Добавляем новый crontab
        add_command = container.exec_run(['crontab', '/tmp/new_crontab'])
        if add_command.exit_code != 0:
            raise Exception("Failed to add new crontab.")

        return jsonify({
            'status': 'success',
            'message': 'Crontab updated successfully.',
            'code': 200
        }), 200

    except Exception as e:
        return jsonify({
            'status': 'error',
            'message': str(e),
            'code': 500
        }), 500


@app.route('/get_jobs_crontab', methods=['GET'])
def get_jobs_crontab():
    try:
        container_name = request.args.get('container_name')

        # Получаем контейнер по имени
        container = client.containers.get(container_name)

        # Выполняем команду crontab -l в контейнере
        exec_command = container.exec_run(['crontab', '-l'])

        if exec_command.exit_code == 0:
            crontab_content = exec_command.output.decode('utf-8')
            return jsonify({
                'status': 'success',
                'crontab': crontab_content,
                'code': 200
            }), 200
        else:
            raise Exception("Failed to retrieve crontab.")

    except Exception as e:
        return jsonify({
            'status': 'error',
            'message': str(e),
            'code': 500
        }), 500

@app.route('/get_crontab', methods=['GET'])
def get_crontab():
    try:
        container_name = request.args.get('container_name')

        # Получаем контейнер по имени
        container = client.containers.get(container_name)

        # Выполняем команду crontab -l в контейнере
        exec_command = container.exec_run(['crontab', '-l'])

        if exec_command.exit_code == 0:
            crontab_content = exec_command.output.decode('utf-8')
            return jsonify({
                'status': 'success',
                'crontab': crontab_content,
                'code': 200
            }), 200
        else:
            raise Exception("Failed to retrieve crontab.")

    except Exception as e:
        return jsonify({
            'status': 'error',
            'message': str(e),
            'code': 500
        }), 500

@app.route('/update-crontab', methods=['POST'])
def update_crontab():
    try:
        data = request.json
        container_name = data['container_name']
        crontab_path = data['crontab_path']

        # Получаем контейнер по имени
        container = client.containers.get(container_name)

        # Обновляем cron-таблицу
        exit_code, output = container.exec_run('bash -c "crontab {crontab_path}"')
        if exit_code != 0:
            raise Exception("Failed to update crontab: {output.decode('utf-8')}")

        return jsonify({
            'status': 'success',
            'message': 'Crontab updated successfully in container {container_name}',
            'code': 200
        }), 200
    except Exception as e:
        return jsonify({
            'status': 'error',
            'message': str(e),
            'code': 500
        }), 500

@app.route('/copy', methods=['POST'])
def copy_crontab():
    try:
        # Получаем данные запроса
        data = request.json
        source_path = data['source_path']
        target_path = data['target_path']
        container_name = data['container_name']

        # Получаем контейнер по имени
        container = client.containers.get(container_name)

        # Проверяем, что файл source_path существует локально
        if not os.path.exists(source_path):
            raise FileNotFoundError("File '{source_path}' not found.")

        # Копируем файл в контейнер
        with open(source_path, 'rb') as file:
            container.put_archive(os.path.dirname(target_path), file.read())

        return jsonify({
            'status': 'success',
            'message': 'File {source_path} copied to {container_name}:{target_path} successfully.',
            'code': 200
        }), 200
    except Exception as e:
        return jsonify({
            'status': 'error',
            'message': str(e),
            'code': 500
        }), 500


@app.route('/restart', methods=['POST'])
def restart_container():
    container_name = request.json.get('container_name')
    if not container_name:
        return jsonify({'error': 'No container name provided'}), 400

    try:
        container = client.containers.get(container_name)
        container.restart()
        return jsonify({'status': 'success', 'message': 'Container {container_name} restarted'}), 200
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
            'message': 'Container {container_name} rebuilt and restarted successfully.',
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
