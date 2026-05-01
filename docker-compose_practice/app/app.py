from flask import Flask
import mysql.connector
import os

app = Flask(__name__)

@app.route('/')
def hello():
    return "<h1>Hello from Flask inside Docker!</h1>"

@app.route('/db')
def db_check():
    try:
        conn = mysql.connector.connect(
            host="db",
            user=os.getenv('MYSQL_USER'),
            password=os.getenv('MYSQL_PASSWORD'),
            database=os.getenv('MYSQL_DATABASE')
        )
        return "<h1>З'єднання з БД успішне!</h1>"
    except Exception as e:
        return f"<h1>Помилка підключення до БД: {str(e)} </h1>"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)