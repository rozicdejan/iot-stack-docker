sudo docker pull netbirdio/netbird

sudo mkdir -p ~/netbird
sudo docker run -d \
  --name netbird \
  --restart unless-stopped \
  --network host \
  -v ~/netbird:/etc/netbird \
  netbirdio/netbird
  
docker exec -it netbird netbird up
#Follow the prompts to complete the setup. You may need to sign up for a Netbird account and follow their instructions to complete the setup.
