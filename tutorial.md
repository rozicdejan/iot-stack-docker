# INSTALL
works for Ubuntu/Debian system
## Step 1. Install Git
    sudo apt-get install git-all
## Step 2. Install Docker 
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
Verify that the Docker Engine installation is successful by running the hello-world image.

    sudo docker run hello-world
This command downloads a test image and runs it in a container. When the container runs, it prints a confirmation message and exits.

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
