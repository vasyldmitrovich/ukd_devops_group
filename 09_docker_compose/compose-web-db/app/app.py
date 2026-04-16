from flask import Flask
import mysql.connector
import os

app = Flask(__name__)

def get_db():
    return mysql.connector.connect(
        host=os.getenv("DB_HOST"),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD"),
        database=os.getenv("DB_NAME"),
    )

@app.route("/")
def home():
    return "Hello"

@app.route("/db")
def db_check():
    try:
        conn = get_db()
        cursor = conn.cursor()

        cursor.execute("SELECT COUNT(*) FROM visits")
        count = cursor.fetchone()[0]

        cursor.execute("INSERT INTO visits () VALUES ()")
        conn.commit()

        return f"DB OK. Visits: {count}"

    except Exception as e:
        return str(e)

app.run(host="0.0.0.0", port=5000)
