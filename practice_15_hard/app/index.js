const express = require('express');
const mysql = require('mysql2');
const app = express();

const db = mysql.createConnection({
    host: 'db', // Ім'я сервісу в compose
    user: 'user',
    password: 'pass',
    database: 'app_db'
});

app.get('/', (req, res) => res.send('<h1>Hello from Node.js App!</h1>'));

app.get('/db', (req, res) => {
    db.query('SELECT text FROM messages', (err, results) => {
        if (err) return res.status(500).send('DB Error: ' + err.message);
        res.json({ status: 'Connected', data: results });
    });
});

app.listen(3000, () => console.log('App running on port 3000'));
