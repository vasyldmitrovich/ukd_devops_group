#!/bin/bash
mysqldump -u wp_prod -p'StrongPass123!' wordpress_db > /opt/wp_backups/wp_$(date +%F).sql
