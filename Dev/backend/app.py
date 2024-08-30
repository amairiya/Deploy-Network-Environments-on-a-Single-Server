from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/api/data', methods=['GET'])
def get_data():
    data = [
        {"id": 1, "name": "Item 1", "description": "Description 1"},
        {"id": 2, "name": "Item 2", "description": "Description 2"},
        {"id": 3, "name": "Item 3", "description": "Description 3"}
    ]
    return jsonify(data)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
