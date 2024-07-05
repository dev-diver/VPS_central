from flask import Flask, request
import subprocess
import os

app = Flask(__name__)

@app.route('/webhook', methods=['POST'])
def webhook():
    if request.method == 'POST':
        # 현재 파이썬 파일의 디렉토리를 구함
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