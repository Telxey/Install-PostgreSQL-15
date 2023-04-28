![postgresql](https://www.vectorlogo.zone/logos/postgresql/postgresql-horizontal.svg)

# Install-PostgreSQL-15
How to Install PostgreSQL 15 on Debian  11 &amp; Ubuntu 22.04 Step-by-Step

#### Prerequisites

Before installing the PostgreSQL server, we must ensure that the system meets the following installation requirements:

Pre-Installed Debian 11 or Ubuntu 22.04
A regular user with sudo rights
An active internet connection
At least 2 GB of RAM with an additional 512 MB of disk space. Please note that this is a minimal requirement for the demo environment. The actual      hardware configuration will vary with data volume.

### 1) Enable PostgreSQL Package Repository

PostgreSQL 15 package is not available yet in the default package repository, so enable its official package repository using following commands.

$ sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

$ wget -qO- https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo tee /etc/apt/trusted.gpg.d/pgdg.asc &>/dev/null

$ sudo apt update

### 2) Install PostgreSQL 15 Database Server and Client

$ sudo apt install postgresql postgresql-client -y
$ sudo systemctl enable postgresql
$ sudo systemctl status postgresql
$ psql --version

### 3) Update PostgreSQL Admin User Password

By default, we can connect to the PostgreSQL server without using any password. Let’s see this in action using the psql utility:

$ sudo -u postgres psql
postgres=#

In the above output, the postgres=#  prompt indicated the active connection with the PostgreSQL server.
In this example, we have used the postgres user. This is an admin user of PostgreSQL and it gets created during the installation process.
Allowing administrative access to the database without any password isn’t a good idea. So, let’s set the password for the postgres user:

postgres=# ALTER USER postgres PASSWORD 'demoPassword';

The above SQL query sets the user password to demoPassword. Please note that, we have used a very simple password because this is a demo environment. However, the same is not recommended in the production environment.

Let’s verify that the password has been set successfully. So first, terminate the current session with the server using the \q command.

postgres=# \q

Output of above commands,

![psql-2-ubuntu-linux](https://user-images.githubusercontent.com/131807761/235006878-aea04791-1ecc-4fc6-9c0f-ce8084f2ef68.png)
Now, let’s connect to the database server again:

$ psql -h localhost -U postgres

Let’s enter the demoPassword string as a password and now we are connected to the database.

![psql-3-ubuntu-linux](https://user-images.githubusercontent.com/131807761/235006700-b30bca38-914e-4f19-a056-1a002fcc7975.png)


### 4) Configure PostgreSQL to Allow Remote Connections

By default, PostgreSQL accepts connections from the localhost only. However, we can easily modify the configuration to allow connection from remote clients.
PostgreSQL reads its configuration from the postgresql.conf file which is located in the /etc/postgresql/<version>/main/ directory. Here, the version indicates the major version of PostgreSQL.
For example, in our case the full path of the file is /etc/postgresql/15/main/postgresql.conf.
Now, open the postgresql.conf file in a text editor, uncomment the line that starts with the listen_addresses, and replace ‘localhost’ with ‘*’.
This setting is located under the CONNECTIONS AND AUTHENTICATION section. After modification the file will look like this:



















