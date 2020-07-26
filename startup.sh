#!/bin/bash
#laravel folder permissions to avoid permission denied errors

echo "Hello World"

#apply 755 file permissions to all directories inside src/
find src/ -type d -exec chmod 755 {} \;

#apply ug+s file permissions to all directories inside src/
find src/ -type d -exec chmod ug+s {} \;

#apply 644 file permissiond to all files inside src/
find src/ -type f -exec chmod 644 {} \;

#Make user:www-data own src/ folder because laravel uses www-data user to write to log files
chown -R ${USER}:"www-data" src/ ;

#change group for src/storage and src/bootstarp/cache so that laravel can write to logs
sudo chgrp -R www-data src/storage src/bootstrap/cache ;
sudo chmod -R ug+rwx src/storage src/bootstrap/cache ;

#make artisan file inside src/ executable so that we can run artisan commands as a docker service
chmod 740 src/artisan ;

#export user id who owns this project to run the docker services with the same user to avoid permission denied errors
export UID=(id -u) ;
