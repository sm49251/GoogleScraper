from flask import Flask, request, jsonify
import subprocess

app = Flask(__name__)

@app.route('/scrape', methods=['POST'])
def scrape():
    data = request.json
    keyword = data.get('keyword', 'test')
    
    # Run the GoogleScraper CLI command
    command = ["GoogleScraper", "-m", "selenium", "--keyword", keyword]
    
    try:
        # Execute the script and capture the output
        result = subprocess.run(command, capture_output=True, text=True)
        return jsonify({"status": "success", "output": result.stdout})
    except Exception as e:
        return jsonify({"status": "error", "message": str(e)})

if __name__ == '__main__':
    # Listen on port 5000
    app.run(host='0.0.0.0', port=5000)
