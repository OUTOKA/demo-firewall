#!/bin/bash

# Create the server VM.
vagrant init debian/bookworm64
vagrant up --vm-name server
vagrant ssh -c "apt-get update && apt-get install -y nginx ufw"
vagrant ssh -c "ufw allow OpenSSH && ufw enable"
vagrant ssh -c "echo 'Hello, world!' > /var/www/html/index.html"

# Create the client VM.
vagrant init debian/bookworm64
vagrant up --vm-name client
vagrant ssh -c "apt-get update && apt-get install -y nmap"

# Configure the network.
echo "config.vm.network "private_network", ip: "192.168.0.10"" >> Vagrantfile
echo "config.vm.network "private_network", ip: "192.168.0.11"" >> Vagrantfile
vagrant reload
