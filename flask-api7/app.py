from flask import Flask, request, jsonify
import docker
import traceback
import tarfile
import io
import os

app = Flask(__name__)
client = docker.from_env()

def create_tarfile(file_name, content):
    tar_stream = io.BytesIO()
    with tarfile.open(fileobj=tar_stream, mode='w') as tar:
        tarinfo = tarfile.TarInfo(name=file_name)
        tarinfo.size = len(content)
        tar.addfile(tarinfo, io.BytesIO(content.encode('utf-8')))
    tar_stream.seek(0)
    return tar_stream

@app.route('/crontab_new_save', methods=['POST'])
def crontab_new_save():
    try:
        new_data = request.form.get('new_data')

        if not new_data:
            return jsonify({'status': 'error', 'message': 'new_data is required.', 'code': 400}), 400

        crontab_path = './../cron/my-crontab'

        with open(crontab_path, 'w') as crontab_file:
            crontab_file.write(new_data)

        return jsonify({'status': 'success', 'message': 'Crontab updated successfully.', 'code': 200}), 200

    except Exception as e:
        return jsonify({'status': 'error', 'message': str(e), 'code': 500}), 500


@app.route('/restart_container', methods=['POST'])
def restart_container():
    try:
        container_name = request.form.get('container_name')
        service_name = request.form.get('service_name')
        compose_file_path = request.form.get('compose_file_path', 'docker-compose.yml')

        if not container_name or not service_name:
            return jsonify({'status': 'error', 'message': 'container_name and service_name are required.', 'code': 400}), 400

        # Остановка контейнера
        container = client.containers.get(container_name)
        container.stop()
        container.remove()

        # Получение образа контейнера
        image_name = container.image.tags[0]

        # Удаление образа
        client.images.remove(image_name, force=True)

        # Пересоздание контейнера через Docker Compose
        subprocess.run(['docker-compose', '-f', compose_file_path, 'up', '--build', '-d', service_name], check=True)

        return jsonify({'status': 'success', 'message': f'Container22 {container_name} restarted successfully.', 'code': 200}), 200

    except docker.errors.NotFound:
        return jsonify({'status': 'error', 'message': 'Container not found.', 'code': 404}), 404

    except docker.errors.ImageNotFound:
        return jsonify({'status': 'error', 'message': 'Image not found.', 'code': 404}), 404

    except subprocess.CalledProcessError as e:
        return jsonify({'status': 'error', 'message': f'Docker Compose error: {str(e)}\n{traceback.format_exc()}', 'code': 500}), 500

    except Exception as e:
        return jsonify({'status': 'error', 'message': f'{str(e)}\n{traceback.format_exc()}', 'code': 500}), 500

@app.route('/containers', methods=['GET'])
def list_containers():
    try:
        containers = client.containers.list(all=True)
        container_list = []
        for container in containers:
            container_info = {
               'id': container.short_id,
			  'name': container.name,
			  'status': container.status,
			  'image': container.image.tags,
# 			  'command': container.attrs['Config']['Cmd'],
# 			  'created': container.attrs['Created'],
			  'ports': container.attrs['NetworkSettings']['Ports'],
# 			  'labels': container.attrs['Config']['Labels'],
			  'volumes': container.attrs['Mounts'],
			  'network': container.attrs['NetworkSettings']['Networks'],
# 			  'environment': container.attrs['Config']['Env'],
# 			  'restart_policy': container.attrs['HostConfig']['RestartPolicy'],
			  'cpu_usage': container.attrs['HostConfig']['NanoCpus'],
			  'memory_usage': container.attrs['HostConfig']['Memory']
            }
            container_list.append(container_info)

        return jsonify({'status': 'success', 'containers': container_list, 'code': 200}), 200

    except Exception as e:
        return jsonify({'status': 'error', 'message': str(e), 'code': 500}), 500

@app.route('/get_crontab', methods=['GET'])
def get_crontab():
    try:
        container_name = request.args.get('container_name')
        if not container_name:
            return jsonify({'status': 'error', 'message': 'container_name is required.', 'code': 400}), 400

        container = client.containers.get(container_name)
        exec_command = container.exec_run(['crontab', '-l'])

        if exec_command.exit_code == 0:
            crontab_content = exec_command.output.decode('utf-8')
            return jsonify({'status': 'success', 'crontab': crontab_content, 'code': 200}), 200
        else:
            raise Exception("Failed to retrieve crontab.")

    except Exception as e:
        return jsonify({'status': 'error', 'message': str(e), 'code': 500}), 500


@app.route('/restart_container1', methods=['POST'])
def restart_cont():
    try:
        container_name = request.form.get('container_name')
        if not container_name:
            return jsonify({'error': 'No container name provided'}), 400

        container = client.containers.get(container_name)
        container.restart()
        return jsonify({'status': 'success', 'message': f'Container {container_name} restarted'}), 200

    except docker.errors.NotFound:
        return jsonify({'error': 'Container not found'}), 404
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/full_update_crontab', methods=['POST'])
def full_update_crontab():
    try:
        container_name = request.form.get('container_name')
        new_crontab_content = request.form.get('crontab_content')

        if not container_name or not new_crontab_content:
            return jsonify({'status': 'error', 'message': 'container_name and crontab_content are required.', 'code': 400}), 400

        container = client.containers.get(container_name)
        clear_command = container.exec_run(['crontab', '-r'])
        if clear_command.exit_code != 0 and "no crontab for" not in clear_command.output.decode('utf-8'):
            raise Exception("Failed to clear crontab.")

        tar_stream = create_tarfile('new_crontab', new_crontab_content)
        container.put_archive('/tmp/', tar_stream)
        add_command = container.exec_run(['crontab', '/tmp/new_crontab'])
        if add_command.exit_code != 0:
            raise Exception("Failed to add new crontab.")

        return jsonify({'status': 'success', 'message': 'Crontab updated successfully.', 'code': 200}), 200

    except Exception as e:
        return jsonify({'status': 'error', 'message': f"{str(e)}\n{traceback.format_exc()}", 'code': 500}), 500

@app.route('/get_jobs_crontab', methods=['GET'])
def get_jobs_crontab():
    try:
        container_name = request.args.get('container_name')
        if not container_name:
            return jsonify({'status': 'error', 'message': 'container_name is required.', 'code': 400}), 400

        container = client.containers.get(container_name)
        exec_command = container.exec_run(['crontab', '-l'])

        if exec_command.exit_code == 0:
            crontab_content = exec_command.output.decode('utf-8')
            return jsonify({'status': 'success', 'crontab': crontab_content, 'code': 200}), 200
        else:
            raise Exception("Failed to retrieve crontab.")

    except Exception as e:
        return jsonify({'status': 'error', 'message': str(e), 'code': 500}), 500

@app.route('/update-crontab', methods=['POST'])
def update_crontab():
    try:
        container_name = request.form.get('container_name')
        crontab_path = request.form.get('crontab_path')
        if not container_name or not crontab_path:
            return jsonify({'status': 'error', 'message': 'container_name and crontab_path are required.', 'code': 400}), 400

        container = client.containers.get(container_name)
        exit_code, output = container.exec_run(f'bash -c "crontab {crontab_path}"')
        if exit_code != 0:
            raise Exception(f"Failed to update crontab: {output.decode('utf-8')}")

        return jsonify({'status': 'success', 'message': f'Crontab updated successfully in container {container_name}', 'code': 200}), 200
    except Exception as e:
        return jsonify({'status': 'error', 'message': str(e), 'code': 500}), 500

@app.route('/copy', methods=['POST'])
def copy_crontab():
    try:
        source_path = request.form.get('source_path')
        target_path = request.form.get('target_path')
        container_name = request.form.get('container_name')
        if not source_path or not target_path or not container_name:
            return jsonify({'status': 'error', 'message': 'source_path, target_path, and container_name are required.', 'code': 400}), 400

        container = client.containers.get(container_name)
        if not os.path.exists(source_path):
            raise FileNotFoundError(f"File '{source_path}' not found.")

        with open(source_path, 'rb') as file:
            container.put_archive(os.path.dirname(target_path), file.read())

        return jsonify({'status': 'success', 'message': f'File {source_path} copied to {container_name}:{target_path} successfully.', 'code': 200}), 200
    except Exception as e:
        return jsonify({'status': 'error', 'message': str(e), 'code': 500}), 500

@app.route('/rebuild', methods=['POST'])
def rebuild_container():
    try:
        container_name = request.form.get('container_name')
        if not container_name:
            return jsonify({'status': 'error', 'message': 'container_name is required.', 'code': 400}), 400

        container = client.containers.get(container_name)
        container.stop()
        container.remove()

        image_name = container.attrs['Config']['Image']
        client.images.build(path=".", tag=image_name)
        client.containers.run(image_name, name=container_name, detach=True)

        return jsonify({'status': 'success', 'message': f'Container {container_name} rebuilt and restarted successfully.', 'code': 200}), 200
    except Exception as e:
        return jsonify({'status': 'error', 'message': str(e), 'code': 500}), 500

@app.errorhandler(405)
def page_not_found(e):
    return jsonify({'status': 'error', 'message': 'The error method.', 'code': 405}), 405

@app.errorhandler(404)
def page_not_found(e):
    return jsonify({'status': 'error', 'message': 'The 11 requested URL was not found on the server. If you entered the URL manually please check your spelling and try again.', 'code': 404}), 404

@app.errorhandler(500)
def internal_server_error(e):
    return jsonify({'status': 'error', 'message': 'An internal server error occurred.', 'code': 500}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
