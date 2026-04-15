#!/bin/bash
# Використовуємо конфіг файл для безпечного входу
mysqldump wordpress_db > /opt/wp_backups/wp_$(date +%F).sql
