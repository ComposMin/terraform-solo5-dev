#!/bin/bash

curl -fsSL https://apt.dockerproject.org/gpg | sudo apt-key add -
sudo add-apt-repository  "deb https://apt.dockerproject.org/repo/ ubuntu-$(lsb_release -cs) main"
sudo apt-get update
sudo apt-get -y install docker-engine
sudo service docker restart
sudo adduser root docker

if id -u ubuntu > /dev/null 2>&1; then 
  sudo adduser ubuntu docker
fi
