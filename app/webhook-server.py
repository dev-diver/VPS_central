from flask import Flask, request, jsonify
import subprocess
import os

app = Flask(__name__)

@app.route('/webhook', methods=['POST'])
def webhook():
    if request.method == 'POST':

        webhook_data = request.get_json()
        print("Webhook received:", webhook_data, flush=True)

        project_dir = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
        
        # # 조건을 만족하지 않으면 조기 리턴
        # if not webhook_data or 'push_data' not in webhook_data:
        #     return 'Ignored', 200

        # push_data = webhook_data['push_data']
        # if 'tag' not in push_data or not push_data['tag'] or 'media_type' not in push_data:
        #     return 'Ignored', 200

        commands = [
            f"echo 'docker client stop' && cd {project_dir} && docker compose stop client",
            f"echo 'docker client rm' && cd {project_dir} && docker compose rm -f client",
            f"echo 'docker compose pull' && cd {project_dir} && docker compose pull",
            f"echo 'docker compose up' && cd {project_dir} && docker compose up -d"
        ]

        output = []
        for command in commands:
            try:
                result = subprocess.run(command, shell=True, check=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
                output.append({
                    'command': command,
                    'output': result.stdout.decode(),
                    'error': result.stderr.decode()
                })
            except subprocess.CalledProcessError as e:
                return jsonify({
                    'command': command,
                    'output': e.stdout.decode(),
                    'error': e.stderr.decode(),
                    'returncode': e.returncode
                }), 400

        return 'Success', 200
    else:
        return 'Method Not Allowed', 405

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)