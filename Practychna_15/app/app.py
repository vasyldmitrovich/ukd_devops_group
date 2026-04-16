from flask import Flask
import mariadb
import os

app = Flask(__name__)

def get_db_connection():
    return mariadb.connect(
        user=os.getenv('MYSQL_USER'),
        password=os.getenv('MYSQL_PASSWORD'),
        host="db",
        port=3306,
        database=os.getenv('MYSQL_DATABASE')
    )

@app.route('/')
def hello():
    return "<h1>Hello from Python App layer! 🚀</h1>"

@app.route('/db')
def test_db():
    try:
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute("SELECT DATABASE();")
        db_name = cur.fetchone()
        conn.close()
        return f"<h1>Успіх! ✅</h1><p>Підключено до бази даних: {db_name[0]}</p>"
    except Exception as e:
        return f"<h1>Помилка підключення ❌</h1><p>{str(e)}</p>"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
