# Install docker:
# 1) Update package database
sudo yum check-update

# 2) Install tmux
sudo yum -y install tmux

# 3) Install Docker
curl -fsSL https://get.docker.com/ | sh

# 4) Start and Automate Docker
sudo systemctl start docker && sudo systemctl enable docker

# 5) Change permissions for docker (optional)
# Allow docker commands without requiring sudo prefix
sudo usermod -a -G docker $USER

# 6) Close terminal
exit


# Compile and upload docker image
# 1) Build docker image specifying name and version
docker build -t gactrading:version .

# 2) Run container to ensure the image works
docker run -it --name gactrading gactrading:version

# 3) Login
docker login

# 4) Tag the image
docker tag gactrading:version eileil1/gactrading:version

# 5) Upload the image
docker push eileil1/gactrading:version


# Launch instance from docker image
# 1) Create folder for your new instance
mkdir gactrading_files

# 2) Create folders for logs, config files and database file
mkdir gactrading_files/gactrading_conf
mkdir gactrading_files/gactrading_logs
mkdir gactrading_files/gactrading_data

# 3) Launch a new instance of gactrading
docker run -it \
--name gactrading-instance \
--mount "type=bind,source=$(pwd)/gactrading_files/gactrading_conf,destination=/conf/" \
--mount "type=bind,source=$(pwd)/gactrading_files/gactrading_logs,destination=/logs/" \
--mount "type=bind,source=$(pwd)/gactrading_files/gactrading_data,destination=/data/" \
eileil1/gactrading:latest

# or use SCRIPT
chmod a+x installation/docker-commands/gac_create.sh
installation/docker-commands/gac_create.sh
