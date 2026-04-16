from flask import Flask, jsonify
import mysql.connector
import os
import time

app = Flask(__name__)

def get_db_connection():
    # Спроби підключення, поки БД піднімається
    for i in range(5):
        try:
            return mysql.connector.connect(
                host=os.getenv('DB_HOST', 'db'),
                user=os.getenv('MYSQL_USER', 'user'),
                password=os.getenv('MYSQL_PASSWORD', 'pass'),
                database=os.getenv('MYSQL_DATABASE', 'app_db')
            )
        except:
            time.sleep(2)
    return None

@app.route('/')
def hello():
    return "<h1>Hello! Nginx -> Flask is working.</h1>"

@app.route('/db')
def test_db():
    conn = get_db_connection()
    if conn:
        cursor = conn.cursor()
        cursor.execute("SELECT message FROM init_test")
        result = cursor.fetchone()
        conn.close()
        return jsonify({"status": "Success", "db_value": result[0]})
    return jsonify({"status": "Error", "message": "Could not connect to DB"}), 500

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)
