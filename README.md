# SDB_DevOps
## Deploy
To deploy, follow these steps:
### (I) Get the source code and define the environment variables
```bash
#############################
# DATABASE                  #
#############################
# Inside this repository, clone the database repository
git clone https://github.com/Senai-Dev-ops/SDB_Database.git
# Edit the be.Dockerfile with your favorite text editor, and define the mysql passwords
cd SDB_Database
nano db.Dockerfile
cd ..
```
```bash
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
```bash
#############################
# FRONTEND                  #
#############################
# Clone the frontend repository
git clone https://github.com/Senai-Dev-ops/SDB_Backend.git
```
### (II) Run Docker compose
By the end of the previous step, you'll have the following directory structure:
SDB_DevOps
  ├── SDB_Database
  ├── SDB_Backend
  └── SDB_Frontend
  
To run the docker compose, you must be on "SDB_DevOps" folder, where the docker-compose.yml file is
```bash
# On "SDB_DevOps" folder
sudo docker compose up -d
# If it's the first time you're running the project, you must generate the first admin user by running:
# First access the backend container bash
sudo docker exec -it sdb_be bash
# Generate the user running
npx db:seed:all
# Finally, exit
exit
# All done!
```
### Ports
This project uses the following ports:
+ Frontend: 80
+ Backend: 4000
+ Database: 30306

If yor are accessing the project on the same machine you deployed it, you can access:
