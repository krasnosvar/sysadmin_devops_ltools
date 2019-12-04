#install in ubuntu
sudo apt-get update
sudo apt-get install libpq-dev postgresql postgresql-contrib
#install on centos8
#https://computingforgeeks.com/how-to-install-postgresql-11-on-centos-rhel-8/
sudo dnf -y install https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm
rpm -qi pgdg-redhat-repo #check repo 
sudo dnf module disable postgresql #Disable postgresql module.
sudo dnf clean all #Then clean yum cache and install PostgreSQL 11 on CentOS 8 / RHEL 8
sudo dnf -y install postgresql11-server postgresql11 postgresql-libs
#After installation, database initialization is required before service can be started
sudo /usr/pgsql-11/bin/postgresql-11-setup initdb
sudo systemctl enable --now postgresql-11
sudo systemctl status postgresql-11
/var/lib/pgsql/11/data/postgresql.conf
#Set PostgreSQL admin user
sudo su - postgres 
psql -c "alter user postgres with password 'StrongPassword'"
#Create a test user and database
[postgres@rhel8 ~]$ psql
psql (11.5)
Type "help" for help.

postgres-# createuser test_user
postgres-# alter user test_user with password 'MyDBpassword';
postgres-# createdb test_db -O test_user
postgres-# grant all privileges on database test_db to test_user;
GRANT
#Login as a test_user  user try to create a table on the Database.
psql -U test_user -h localhost -d test_db