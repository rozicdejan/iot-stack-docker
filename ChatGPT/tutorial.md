# Full Procedure with Docker and Portainer Installation
Here is the complete procedure, including Docker and Portainer installation along with the steps to configure Docker for non-root usage:

## Update the system:

    sudo apt-get update
    sudo apt-get upgrade -y
    
## Install Docker:

    sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io
    sudo systemctl enable docker
    sudo systemctl start docker
  
## Install Docker Compose:

    sudo curl -L "https://github.com/docker/compose/releases/download/v2.10.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
## Configure Docker to be used without sudo:

    sudo groupadd docker
    sudo usermod -aG docker $USER
    newgrp docker
## Verify Docker setup without sudo:

    docker run hello-world
## Install Portainer:

    docker volume create portainer_data
    docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest
After completing these steps, you should be able to use Docker commands without sudo and have Portainer running on your system. You can access the Portainer web interface at https://<your-server-ip>:9443.

# Summary of Commands

    # Update and upgrade system
    sudo apt-get update
    sudo apt-get upgrade -y
    
    # Install Docker
    sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io
    sudo systemctl enable docker
    sudo systemctl start docker
    sudo docker --version
    
    # Install Docker Compose
    sudo curl -L "https://github.com/docker/compose/releases/download/v2.10.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    
    # Install Portainer
    sudo docker volume create portainer_data
    sudo docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest
    Now you should have Docker and Portainer running on your Ubuntu system, ready to manage your containers.
# Docker Compose file to install Node-RED, InfluxDB, and Grafana with default settings using Portainer
You will need a docker-compose.yaml file that defines these services. Below is an example of such a file:

    version: '3.8'
    
    services:
      node-red:
        image: nodered/node-red
        container_name: node-red
        ports:
          - "1880:1880"
        volumes:
          - node_red_data:/data
    
      influxdb:
        image: influxdb:latest
        container_name: influxdb
        ports:
          - "8086:8086"
        volumes:
          - influxdb_data:/var/lib/influxdb
        environment:
          - INFLUXDB_DB=mydb
          - INFLUXDB_HTTP_AUTH_ENABLED=true
          - INFLUXDB_ADMIN_USER=admin
          - INFLUXDB_ADMIN_PASSWORD=adminpassword
    
      grafana:
        image: grafana/grafana
        container_name: grafana
        ports:
          - "3000:3000"
        volumes:
          - grafana_data:/var/lib/grafana
        environment:
          - GF_SECURITY_ADMIN_USER=admin
          - GF_SECURITY_ADMIN_PASSWORD=adminpassword
    
      homeassistant:
        image: homeassistant/home-assistant:stable
        container_name: homeassistant
        volumes:
          - homeassistant_data:/config
        environment:
          - TZ=Europe/Ljubljana
        restart: unless-stopped
        network_mode: host
    
      mosquitto:
        image: eclipse-mosquitto
        container_name: mosquitto
        ports:
          - "1883:1883"
          - "9001:9001"
        volumes:
          - mosquitto_data:/mosquitto/data
          - mosquitto_config:/mosquitto/config
          - mosquitto_logs:/mosquitto/log
    
      zigbee2mqtt:
        image: koenkk/zigbee2mqtt
        container_name: zigbee2mqtt
        volumes:
          - zigbee2mqtt_data:/app/data
        environment:
          - TZ=Europe/Ljubljana
        devices:
          - "/dev/ttyUSB0:/dev/ttyUSB0"
        depends_on:
          - mosquitto
    
    volumes:
      node_red_data:
      influxdb_data:
      grafana_data:
      homeassistant_data:
      mosquitto_data:
      mosquitto_config:
      mosquitto_logs:
      zigbee2mqtt_data:
## Instructions - Install in portainer:
    Save the File: Save the above content into your docker-compose.yaml file.
    Upload to Portainer:
        Go to your Portainer dashboard.
        Navigate to Stacks.
        Click on Add stack.
        Name your stack (e.g., smart_home_stack).
        Copy the content of your docker-compose.yaml file into the Web editor.
        Click on Deploy the stack.

    Explanation:
    Home Assistant: Runs with host networking to easily integrate with your local network. It stores its configuration in the homeassistant_data volume.
    Mosquitto (MQTT Broker): Exposes ports 1883 (MQTT) and 9001 (WebSockets) and stores data and logs in their respective volumes.
    Zigbee2MQTT: Connects to the Zigbee USB stick (usually /dev/ttyUSB0, adjust if needed) and stores its configuration in the zigbee2mqtt_data volume. It depends on the Mosquitto service to start correctly.
   
    Note:
    Ensure your Zigbee USB stick is correctly identified as /dev/ttyUSB0 or adjust it accordingly in the zigbee2mqtt service definition.
    You may need to configure the Zigbee2MQTT and Home Assistant settings after the containers are up, to properly connect them to the MQTT broker and other integrations.
    This setup will give you a complete smart home monitoring and control stack with Node-RED, InfluxDB, Grafana, Home Assistant, Zigbee2MQTT, and Mosquitto.

## Instructions - Install in terminal:
Run the Docker Compose file with the following command:

    docker-compose up -d

Explanation:

The -d flag runs the containers in detached mode (in the background).

###Verify the Containers are Running

You can verify that your containers are running with:

    docker ps
This command lists all running containers. You should see entries for node-red, influxdb, grafana, homeassistant, mosquitto, and zigbee2mqtt.

### Access the Services
Home Assistant: http://<your-server-ip>:8123
Node-RED: http://<your-server-ip>:1880
Grafana: http://<your-server-ip>:3000
InfluxDB: http://<your-server-ip>:8086
Replace <your-server-ip> with the actual IP address of your server.
