from flask import Flask, render_template
import subprocess

app = Flask(__name__)

# RTSP-URL камеры (берется из переменной окружения)
RTSP_URL = "rtsp://admin:123456@192.168.1.103:554/stream1"

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/video')
def video():
    # Запускаем FFmpeg для трансляции RTSP в HTTP-поток
    ffmpeg_command = [
        'ffmpeg',
        '-i', RTSP_URL,
        '-f', 'mpegts',
        '-codec:v', 'mpeg1video',
        '-b:v', '1000k',
        '-r', '30',
        'http://localhost:8081/supersecret'
    ]
    subprocess.Popen(ffmpeg_command)
    return "Video stream started"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)