#!/bin/bash

 sudo apt update -y
 sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
 
 wget -qO- https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo tee /etc/apt/trusted.gpg.d/pgdg.asc &>/dev/null

 sudo apt update && sudo apt upgrade -y
 
 #2) Install PostgreSQL 15 Database Server and Client
 
sudo apt install postgresql postgresql-client -y
sudo -u postgres psql --command '\password'
sudo systemctl enable postgresql
sudo systemctl status postgresql
psql --version
psql -h localhost -U postgres
psql --command '\q'
rm psql15.sh
