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
            log_file_path = os.path.join(root_dir, 'update.log')
            
            with open(log_file_path, 'a') as log_file:
                log_file.write(f"Webhook triggered at {current_dir}\n")
                
                # Run the script to pull and restart the containers
                process = subprocess.run(['sh', script_path], stdout=log_file, stderr=log_file)
                
                # Check for errors
                if process.returncode != 0:
                    log_file.write(f"Script failed with return code {process.returncode}\n")
                else:
                    log_file.write("Script executed successfully\n")
                    
        return 'Success', 200
    else:
        return 'Method Not Allowed', 405

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)