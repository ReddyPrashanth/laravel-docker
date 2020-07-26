# Laravel using Docker
A laravel local development boilerplate setup with laravel passport, npm (node dependency manager), composer (php dependency mananager) and nginx. This setup does not require php, npm and composer installed ion your system. Docker will take care of installing them for you.

## Follow below steps to setup
Please follow below steps to setup in linux server. Before setting up make sure Docker is up and running and install Git and docker-compose. [Docker installation guide](https://docs.docker.com/engine/install/). [Git Installation guide from Digital Ocean](https://www.digitalocean.com/community/tutorials/how-to-contribute-to-open-source-getting-started-with-git). [Docker compose installation guide](https://docs.docker.com/compose/install/).


### creating a user

create a user to run php, npm and composer and setup a password to created user. This is required to run docker services as a non-root user. Ignore below command if you already have a not root user.
> sudo useradd {testuser}
> sudo passwd {testuser}

add user to groups docker and www-data.
> sudo usermod -aG docker ${USER}
> sudo usermod -aG www-data ${USER}

### clone this project
use [this url](https://github.com/ReddyPrashanth/laravel-docker.git) to clone the project. cd into **{project-folder}/** and run below shell commands to add USER_ID.

> nano ~/.bashrc

adding a env variable to run docker services

> export USER_ID=$(id -u ${USER}):$(id -g ${USER})

Below command applies the changes and persists the environment variables across all sessions.

> source ~/.bashrc

cd in to **{project-folder}/src/**. Copy .env.example to .env and edit edit below env variables inside .env. Make sure to specify the same mysql environment as you specified on **docker-compose.yml** file.

> DB_CONNECTION=mysql

> DB_HOST=mysql

> DB_PORT=3306

> DB_DATABASE=homestead

> DB_USERNAME=homestead

> MYSQL_PASSWORD: secret


### start docker services
I have included 6 services (nginx, mysql, php, npm, composer and artisan) inside docker-compose.yml file. You are free to edit the mysql database config in this file. Run below command inside project folder to start the services.

> docker-compose up -d --build

Use below command to teardown the docker services.

> docker-compose down

Once all services are up and running install laravel and node dependencies.

> docker-compose run --rm composer install

> docker-compose run --rm artisan key:generate

> docker-compose run --rm artisan migrate 

> docker-compose run --rm artisan config:cache

> docker-compose run --rm npm install

> docker-compose run --rm npm run dev


Navigate to [http://localhost:8088](http://localhost:8088) where you can register and login. Navigate to sample api endpoint [http://localhost:8088/api/hello](http://localhost:8088/api/hello) where you will see below response.

```
   {
    "message": "Hi, from Laravel.",
    "description": "Laravel local development instance running on docker."
    } 
```

### Coming soon... How to create OAuth clients using laravel passport?



