# SDB_DevOps
## Deploy
```
#############################
# DATABASE                  #
#############################
# Inside this repository, clone the database repository
git clone https://github.com/Senai-Dev-ops/SDB_Database.git
# Edit the be.Dockerfile with your favorite text editor
cd SDB_Database
nano be.Dockerfile
```
```
#############################
# BACKEND                   #
#############################
# Clone the backend repository
git clone https://github.com/Senai-Dev-ops/SDB_Backend.git
cd SDB_Backend

# Create a .env file containing the following information (do not forget to edit before executing):
cat > .env << EOF
# Seting project to run as production
NODE_ENV=production
# User for the backend access securely the database
USER_DB=backend
# (ATTENTION) Set here the password for the previous user
PASSWORD_DB=passwd
# Database created with sql script
DATABASE=usuario
# Network cofigured on docker compose
HOST_DB=sdb_db
# Port cofigured on docker compose, to acess the database
HOST_PORT=3306
# Backend listening port
PORT=4000
# (ATTENTION) Set here the first admin user, to access the dashboard
DEFAULT_USER_PASS=passwd
# (ATTENTION) Set here the secret for jwt hash
SECRET=secret
EOF

cd ..
```
```
#############################
# FRONTEND                  #
#############################
```
