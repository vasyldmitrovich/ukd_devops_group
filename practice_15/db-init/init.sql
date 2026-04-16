CREATE TABLE IF NOT EXISTS init_test (
    id INT AUTO_INCREMENT PRIMARY KEY,
    message VARCHAR(255) NOT NULL
);
INSERT INTO init_test (message) VALUES ('Hello from MariaDB SQL Init!');
