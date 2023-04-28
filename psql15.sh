! /bin/bash
#Install PostgreSQL 15 on Ubuntu 22.04

 #1) Enable PostgreSQL Package Repository

 sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
 
 wget -qO- https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo tee /etc/apt/trusted.gpg.d/pgdg.asc &>/dev/null

 sudo apt update && sudo apt upgrade -y
 
 #2) Install PostgreSQL 15 Database Server and Client
 
sudo apt install postgresql postgresql-client -y
sudo systemctl enable postgresql
sudo systemctl status postgresql && q
psql --version 