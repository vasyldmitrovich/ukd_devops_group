#!/bin/bash
sudo mysqldump wordpress_db > /home/vagrant/wordpress_db_backup_$(date +%F).sql
