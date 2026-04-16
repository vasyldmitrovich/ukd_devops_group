from flask import Flask
import mysql.connector
import os

app = Flask(__name__)

def get_db_connection():
    return mysql.connector.connect(
        host="db",
        user=os.getenv("MYSQL_USER"),
        password=os.getenv("MYSQL_PASSWORD"),
        database=os.getenv("MYSQL_DATABASE")
    )

@app.route('/')
def hello():
    return "<h1>Hello from Flask!</h1>"

@app.route('/db')
def test_db():
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT message FROM test_table LIMIT 1;")
        row = cursor.fetchone()
        cursor.close()
        conn.close()
        return f"Connected! DB Message: {row[0]}"
    except Exception as e:
        return f"DB Connection failed: {str(e)}"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
