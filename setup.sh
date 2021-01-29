#This script install docker & docker-compose on UBUNTU for AWS or Hetzner
#!/bin/bash
#Change TimeZone
sudo timedatectl set-timezone Europe/Minsk
#-----------------
sudo apt update -y && sudo apt upgrade -y
#Change ServerName
#sudo chown ubuntu /etc/hostname && sudo echo "LOOK" > /etc/hostname && sudo chown root /etc/hostname
#------------------

ssh -A -i ec2.pem -J ubuntu@11.111.11.1 ubuntu@111.1.1.1

#Docker & Docker-compose install
sudo apt-get update && sudo apt-get upgrade -y && sudo groupadd docker && sudo usermod -aG docker $USER && sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && sudo apt-get update && sudo apt-get install docker-ce docker-ce-cli containerd.io -y && sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && sudo chmod +x /usr/local/bin/docker-compose

#------------------

#PM2 + NodeJS
curl -sL https://deb.nodesource.com/setup_14.x -o nodesource_setup.sh && sudo bash nodesource_setup.sh
sudo apt install nodejs
sudo apt install build-essential -y

sudo npm install pm2@latest -g && pm2 startup systemd && sudo env PATH=$PATH:/usr/bin /usr/lib/node_modules/pm2/bin/pm2 startup systemd -u ubuntu --hp /home/ubuntu && systemctl status pm2-sammy

sudo apt install nginx

pm2 start hello.js
#-------------------

#GOCD installation
sudo apt update -y && sudo apt upgrade -y && echo "deb https://download.gocd.org /" | sudo tee /etc/apt/sources.list.d/gocd.list && curl https://download.gocd.org/GOCD-GPG-KEY.asc | sudo apt-key add - && sudo apt-get update && sudo apt-get install go-agent && sudo apt-get install go-server && sudo systemctl start go-server go-agent

#Jenkins installation
sudo apt update -y && sudo apt upgrade -y && sudo apt install openjdk-11-jdk -y && wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add - && sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list' && sudo apt-get update && sudo apt-get install jenkins -y && sudo apt-get install git -y && sudo systemctl start jenkins && sleep 30 && sudo usermod -aG docker jenkins && sudo cat /var/lib/jenkins/secrets/initialAdminPassword 




