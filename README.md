# SDB_DevOps
## Deploy
Important: we used Ubuntu Server 20.04 LTS and Docker to host our project. If you only want to test it, virtualize the Ubuntu* and install Docker with the subsequent commands:
```bash
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update
 sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin

# From: https://docs.docker.com/engine/install/ubuntu/
```
* It's interesting to create a bridged network connection, assuming that you want to access outside the server.
To deploy, follow these steps:
### (I) Get the source code and define the environment variables
```bash
# Clone this repository
git clone https://github.com/Senai-Dev-ops/SDB_DevOps.git
cd SDB_DevOps
```
```bash
#############################
# DATABASE                  #
#############################
# Inside the SDB_DevOps, clone the database repository
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
git clone https://github.com/Senai-Dev-ops/SDB_Frontend.git
```
### (II) Run Docker compose
By the end of the previous step, you'll have the following directory structure:
```
SDB_DevOps
  ├── SDB_Database
  ├── SDB_Backend
  └── SDB_Frontend
```
  
Important: to run the docker compose, you must be on "SDB_DevOps" folder, where the docker-compose.yml file is.
```bash
# On "SDB_DevOps" folder
sudo docker compose up -d
# If it's the first time you're running the project, you must generate the first admin user by running:
# First access the backend container bash
sudo docker exec -it sdb_be bash
# Generate the user running
npx sequelize db:seed:all
# Finally, exit
exit
# All done!
```
### Ports
This project uses the following ports:
+ Frontend: 80
+ Backend: 4000
+ Database: 30306
