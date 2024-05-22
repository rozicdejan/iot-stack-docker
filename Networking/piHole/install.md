# Steps to Use This File:
## Create Docker Compose File: Save the above YAML content to a file named docker-compose.yml.
## Create Directories: Create the directories for the volumes:

    mkdir etc-pihole etc-dnsmasq.d
## Start Pi-hole: Run the following command to start Pi-hole with Docker Compose:

    docker-compose up -d
Access Web Interface: Open your web browser and navigate to http://<your_host_ip> to access the Pi-hole web interface. Use the password specified in the WEBPASSWORD environment variable to log in.
