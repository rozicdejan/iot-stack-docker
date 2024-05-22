# INSTALL
works for Ubuntu/Debian system
## Step 1. Install Git
    sudo apt-get install git-all
## Step 2. Install Docker 
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

or

    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
Verify that the Docker Engine installation is successful by running the hello-world image.

    sudo docker run hello-world
This command downloads a test image and runs it in a container. When the container runs, it prints a confirmation message and exits.

### Add Group docker
    sudo groupadd docker
### Add user to docker group
    sudo usermod -aG docker $USER
### Activate the changes to groups
    newgrp docker
## Verify that you can run docker commands without sudo
     docker run hello-world    
# Configure Docker to start on boot with systemd
Many modern Linux distributions use systemd to manage which services start when the system boots. On Debian and Ubuntu, the Docker service starts on boot by default. To automatically start Docker and containerd on boot for other Linux distributions using systemd, run the following commands:

     sudo systemctl enable docker.service
     sudo systemctl enable containerd.service
To stop this behavior, use disable instead.


     sudo systemctl disable docker.service
     sudo systemctl disable containerd.service
# Option1 : Install Portainer
## Deployment
First, create the volume that Portainer Server will use to store its database:

    docker volume create portainer_data
Then, download and install the Portainer Server container:

    docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest
By default, Portainer generates and uses a self-signed SSL certificate to secure port 9443. Alternatively you can provide your own SSL certificate during installation or via the Portainer UI after installation is complete.

If you require HTTP port 9000 open for legacy reasons, add the following to your docker run command:

    -p 9000:9000

Portainer Server has now been installed. You can check to see whether the Portainer Server container has started by running docker ps:

    root@server:~# docker ps
    CONTAINER ID   IMAGE                          COMMAND                  CREATED       STATUS      PORTS  NAMES             
    de5b28eb2fa9   portainer/portainer-ce:latest  "/portainer"             2 weeks ago   Up 9 days   
### Logging In
Now that the installation is complete, you can log into your Portainer Server instance by opening a web browser and going to:
    
    https://localhost:9443
# Install packages and software for IOT
## Step 3: Clone GitHub stack
    git clone https://github.com/rozicdejan/iot-stack-docker.git
## Step 4: Change docker-compose file
change data in ./docker-compose.yaml file

    cd iot-stack-docker/
    nano ./docker-compose.yaml
    
## Step 5: Docker compose
Grafana: https://hub.docker.com/r/grafana/grafana, Node-red: https://hub.docker.com/r/nodered/node-red, mqqt:https://hub.docker.com/_/eclipse-mosquitto, influxdb: https://hub.docker.com/_/influxdb      

move to DIR and compose file

    cd iot-stack-docker/
    docker-compose up -d //inside same DIR as  docker-compose.yaml

More info: https://www.youtube.com/watch?v=mzYdsPUI1TA&ab_channel=PhilippEchteler
