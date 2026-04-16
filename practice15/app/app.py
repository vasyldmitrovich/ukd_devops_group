from flask import Flask, jsonify
import mysql.connector
import os

app = Flask(__name__)

@app.route('/')
def hello():
    return "🚀 Hello from DevOps Python App Layer!"

@app.route('/db')
def check_db():
    try:
        conn = mysql.connector.connect(
            host=os.environ.get('DB_HOST', 'db'),
            user=os.environ.get('DB_USER', 'user'),
            password=os.environ.get('DB_PASS', 'pass'),
            database=os.environ.get('DB_NAME', 'app_db')
        )
        cursor = conn.cursor()
        cursor.execute("SELECT text FROM messages LIMIT 1;")
        result = cursor.fetchone()
        conn.close()
        return jsonify({"status": "success", "db_message": result[0]})
    except Exception as e:
        return jsonify({"status": "error", "message": str(e)})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
