cd /var/www/
tar -xzf wordpress_v5.tar.gz -C localhost
chown -R www-data /var/www/* && chmod -R 755 /var/www/*

if [[ "$AUTOINDEX" != "off" ]]
then
  export AUTOINDEX="on"
fi

sed "s/AI_VAR/$AUTOINDEX/g" ngnx.conf > /etc/nginx/sites-available/localhost
ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/localhost

echo "admin:jY5lVv9PJN4DQ" >> /etc/nginx/pma_pass

service mysql start
service php7.3-fpm start
service nginx start

echo "CREATE USER 'wp_user'@'localhost' identified by 'wp_passwd';
      CREATE DATABASE wp_database;
      GRANT ALL PRIVILEGES ON wp_database.* TO 'wp_user'@'localhost';
      FLUSH PRIVILEGES;" | mysql -uroot

mysql -uroot wp_database < ./localhost/wordpress/wp_table.sql
rm ./localhost/wordpress/wp_table.sql

echo "nginx autoindex is "$AUTOINDEX
echo "To change the autoindex add the --env option with the AUTOINDEX value when starting the container"

bash