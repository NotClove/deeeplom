from flask import Flask, send_file, jsonify
from prometheus_flask_exporter import PrometheusMetrics
import os
import random

# Constants
PORT = 8000
VERSION = "Deeeplom project: v0.1"
IMG_DIR = "./img"

app = Flask(__name__)
metrics = PrometheusMetrics(app)

# Health status
HEALTH_STATUS = True

def random_image_path():
    """
    Return a random image path from the ones in the IMG_DIR directory
    """
    img_list = os.listdir(IMG_DIR)
    return os.path.join(IMG_DIR, random.choice(img_list))

@app.route('/health')
def health():
    """
    Return healthcheck status
    """
    health = "healthy" if HEALTH_STATUS else "unhealthy"
    return jsonify(health=health), 200 if HEALTH_STATUS else 500

@app.route('/v')
def version():
    """
    Return simple version string
    """
    return VERSION

@app.route('/')
def main():
    """
    Return a random image directly through send_file
    """
    image_path = random_image_path()
    return send_file(image_path, mimetype='image/png')

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=PORT)