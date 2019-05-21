#! /bin/bash 

sudo docker rm --force `sudo docker ps -aq`
sudo docker system prune --all --volumes --force
