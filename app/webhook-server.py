from flask import Flask, request
import subprocess
import os

app = Flask(__name__)

@app.route('/webhook', methods=['POST'])
def webhook():
    if request.method == 'POST':
        data = request.get_json()
        if data.get('ref') == 'refs/heads/main':
            # 현재 파이썬 파일의 디렉토리를 구함
            current_dir = os.path.dirname(os.path.realpath(__file__))
            root_dir = os.path.abspath(os.path.join(current_dir, os.pardir))
            script_path = os.path.join(root_dir, 'docker-compose-update.sh')
            # Run the script to pull and restart the containers
            subprocess.Popen([script_path])
        return 'Success', 200
    else:
        return 'Method Not Allowed', 405

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)