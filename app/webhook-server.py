from flask import Flask, request
import subprocess
import os
import json

app = Flask(__name__)

@app.route('/webhook', methods=['POST'])
def webhook():
    if request.method == 'POST':

        webhook_data = request.get_json()
        print("Webhook received:", json.dumps(webhook_data, indent=4))
        
        # # 조건을 만족하지 않으면 조기 리턴
        # if not webhook_data or 'push_data' not in webhook_data:
        #     return 'Ignored', 200

        # push_data = webhook_data['push_data']
        # if 'tag' not in push_data or not push_data['tag'] or 'media_type' not in push_data:
        #     return 'Ignored', 200

        current_dir = os.path.dirname(os.path.realpath(__file__))
        root_dir = os.path.abspath(os.path.join(current_dir, os.pardir))
        script_path = os.path.join(root_dir, 'docker-compose-update.sh')
        # Run the script to pull and restart the containers
        
        print(f"Webhook triggered at {current_dir}")
        
        # Run the script to pull and restart the containers
        process = subprocess.run(['sh', script_path], stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
        
        # Output stdout and stderr to console
        print(process.stdout)
        print(process.stderr)
        
        # Check for errors
        if process.returncode != 0:
            print(f"Script failed with return code {process.returncode}")
        else:
            print("Script executed successfully")

        return 'Success', 200
    else:
        return 'Method Not Allowed', 405

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)