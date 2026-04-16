from flask import Flask
import mysql.connector

app = Flask(__name__)

@app.route("/")
def home():
    return "Hello from App!"

@app.route("/db")
def db():
    try:
        conn = mysql.connector.connect(
            host="db",
            user="user",
            password="pass",
            database="app_db"
        )
        return "DB OK"
    except:
        return "DB FAIL"

app.run(host="0.0.0.0", port=5000)
