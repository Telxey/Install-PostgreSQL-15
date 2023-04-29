![postgresql](https://www.vectorlogo.zone/logos/postgresql/postgresql-horizontal.svg)

# Installing PostgreSQL-15

#### Prerequisites

Before installing the PostgreSQL server, we must ensure that the system meets the following installation requirements:

- Pre-Installed Debian 11 or Ubuntu 22.04
- A regular user with sudo rights
- An active internet connection
- At least 2 GB of RAM with an additional 512 MB of disk space. Please note that this is a minimal requirement for the demo environment. The actual        hardware configuration will vary with data volume.

###### 2 Options to Install Prosgresql-15  Option 1- Easy way or 2- step-by-Step

# Install-Postgresql-15 Fast one command Install

    wget -O psql15.sh https://raw.githubusercontent.com/Telxey/Install-PostgreSQL-15/main/psql15.sh && sudo bash psql15.sh PostgreSQL-15
Now you are on loged on administrative user 'postgresql' If everythinng is OK output need to look like bellow

![oneclik](https://user-images.githubusercontent.com/131807761/235279045-fab02cc4-25e0-4411-be6e-73f23de76bb3.png)

Now just tpe command '\q' to exit and All set

    \q

- If you need remote clients connections go to step  4 for Remote access configurations

# Install-PostgreSQL-15  Step-by-Step
How to Install PostgreSQL 15 on Debian  11 &amp; Ubuntu 22.04 Step-by-Step


### 1) Enable PostgreSQL Package Repository

PostgreSQL 15 package is not available yet in the default package repository, so enable its official package repository using following commands.

    sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
.

    wget -qO- https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo tee /etc/apt/trusted.gpg.d/pgdg.asc &>/dev/null
.

    sudo apt update && sudo apt upgrade -y

### 2) Install PostgreSQL 15 Database Server and Client

    sudo apt install postgresql postgresql-client -y
.
    
    sudo systemctl enable postgresql
    sudo systemctl status postgresql
    psql --version
 ##### Output sample    
  - active and runing service and postgresql 15.2 installed  

![psql status](https://user-images.githubusercontent.com/131807761/235043529-4148f7a1-e8ac-4da9-a53f-7618c84db1a0.png)

### 3) Update PostgreSQL Admin User Password

By default, we can connect to the PostgreSQL server without using any password. Let’s see this in action using the psql utility:

 - become the “postgres” system user (either via the root user, sudo or through SSH public key authentication)
 - connect to the local server using “psql”

       sudo -u postgres psql
###### postgres=#


In the above output, the postgres=#  prompt indicated the active connection with the PostgreSQL server.
In this example, we have used the postgres user. This is an admin user of PostgreSQL and it gets created during the installation process.
Allowing administrative access to the database without any password isn’t a good idea. So, let’s set the password for the postgres user:


###### postgres=# 
    \password
![password](https://user-images.githubusercontent.com/131807761/235136842-0ab37a18-ac6e-4b71-a851-a18ac0d896ed.png)

The above SQL query '/password' Let set secret-password for the user postgres for administrative access. 

Let’s verify that the password has been set successfully. So first, terminate the current session with the server using the \q command.

###### postgres=#
     \q


Now, let’s connect to the database server again:

    psql -h localhost -U postgres

Let’s enter the SecretPassword you choice string as a password and now we are connected to the database.

![passwd-down](https://user-images.githubusercontent.com/131807761/235140826-81d3f944-2df7-479c-8393-532e18f89bd9.png)

run \q to exit

    \q 

Now PosgreSQL is secure for productions environment

### 4) Configure PostgreSQL to Allow Remote Connections

By default, PostgreSQL accepts connections from the localhost only. we can easily modify to allow connection from remote clients.

PostgreSQL reads its configuration from the postgresql.conf file directory. Here, the version indicates the major version of PostgreSQL.
       
   For example, file which is located in the '/etc/postgresql/version/main/'
   
   Our example, in our case the full path of the file is '/etc/postgresql/15/main/postgresql.conf'

open the postgresql.conf file in a text editor, uncomment the line that starts with the listen_addresses, and replace ‘localhost’ with ‘*’.
change PORT 5432 if you prefer, This setting is located under the CONNECTIONS AND AUTHENTICATION section. 
   
    sudo nano /etc/postgresql/15/main/postgresql.conf    

![remote1](https://user-images.githubusercontent.com/131807761/235156452-17089268-7d95-48dd-8f88-b2288ddbda88.png)


After modification the file will look like this:

![remote2](https://user-images.githubusercontent.com/131807761/235159394-6326b82e-e93e-44bc-86b2-d40c35d0c698.png)

Save and close the file.

Next, edit the IPv4 local connections section of the pg_hba.conf file to allow IPv4 connections from all clients. Please note that this file is also located in /etc/postgresql/15/main/ directory. at the end of file modify HOST_IP as below

    sudo nano /etc/postgresql/15/main/pg_hba.conf

![ipconfg1](https://user-images.githubusercontent.com/131807761/235167670-a7d71816-4b2c-42a9-9ba2-63f95b6d33b5.png)

After modification the file will look like this:

![ipconf2](https://user-images.githubusercontent.com/131807761/235168921-c69b2088-02ee-417c-a1c2-8f303dad7ddc.png)

use 0.0.0.0/0 to accept reemote connections from anywhere or espesific subnet or IP you need

In case, Ubuntu firewall is running on your system then allow PostgreSQL 5432 port using following command,

    sudo ufw allow 5432/tcp
Restart PostgreSQL service and verify it’s up and running:

    sudo systemctl restart postgresql
    sudo systemctl status postgresql

### 5) Verifying Remote Connection

Now, let’s try to access DB from remote client.

In this example, 23.227.173.28 is the IP address of the PostgreSQL database server. And use remote client from another region

    psql -h 23.227.173.28 -U postgres
      
  ![term1](https://user-images.githubusercontent.com/131807761/235279166-b24e45b9-3af5-41be-bf8f-2be0778918ed.png)
  
  If have a Command 'psql' not found, error can fix installing client use command bellow
  
  
    






