#!/bin/bash
sleep 1m
#Update any ec2 Services
sudo yum update -y

cd /home/ec2-user

#get and extract Atlantis
wget https://github.com/runatlantis/atlantis/releases/download/v0.11.1/atlantis_linux_386.zip
unzip atlantis_linux_386.zip -d /usr/local/bin/
rm -v atlantis_linux_386.zip

#get and extract terraform
wget https://releases.hashicorp.com/terraform/0.12.24/terraform_0.12.24_linux_amd64.zip
unzip terraform_0.12.24_linux_amd64.zip -d /usr/local/bin/

rm -v terraform_0.12.24_linux_amd64.zip

echo "export ATLANTIS_URL=http://atlantis.aws.awisys.eu" >> .bashrc
echo "export ATLANTIS_GH_USER=infra.builder.atlantis@interia.pl">> .bashrc
echo "export ATLANTIS_GH_TOKEN=26197b6d551a30986d2ed3fdf215c9585d425e95" >> .bashrc
echo "export ATLANTIS_GH_WEBHOOK_SECRET=XHy7XzMXk22msNRBqvFCmJnpmg2mezWGHLC3dtdW" >> .bashrc
echo "export ATLANTIS_REPO_WHITELIST=github.com/Infra-Builders-GFT/*" >> .bashrc

echo "PATH=$PATH:/home/ec2-user/bin" >> /root/.bashrc
echo "export ATLANTIS_URL=http://atlantis.aws.awisys.eu" >> /root/.bashrc
echo "export ATLANTIS_GH_USER=infra.builder.atlantis@interia.pl">> /root/.bashrc
echo "export ATLANTIS_GH_TOKEN=26197b6d551a30986d2ed3fdf215c9585d425e95" >> /root/.bashrc
echo "export ATLANTIS_GH_WEBHOOK_SECRET=XHy7XzMXk22msNRBqvFCmJnpmg2mezWGHLC3dtdW" >> /root/.bashrc
echo "export ATLANTIS_REPO_WHITELIST=github.com/Infra-Builders-GFT/*" >> /root/.bashrc

touch /etc/systemd/system/atlantis.service
echo "[Unit]" >> /etc/systemd/system/atlantis.service
echo "Description=AtlantisService" >> /etc/systemd/system/atlantis.service
echo " " >> /etc/systemd/system/atlantis.service
echo "[Service]" >> /etc/systemd/system/atlantis.service
echo "Environment=ATLANTIS_URL=http://atlantis.aws.awisys.eu" >> /etc/systemd/system/atlantis.service
echo "Environment=ATLANTIS_GH_USER=infra.builder.atlantis@interia.pl" >> /etc/systemd/system/atlantis.service
echo "Environment=ATLANTIS_GH_TOKEN=26197b6d551a30986d2ed3fdf215c9585d425e95" >> /etc/systemd/system/atlantis.service
echo "Environment=ATLANTIS_GH_WEBHOOK_SECRET=XHy7XzMXk22msNRBqvFCmJnpmg2mezWGHLC3dtdW" >> /etc/systemd/system/atlantis.service
echo "Environment=ATLANTIS_REPO_WHITELIST=github.com/Infra-Builders-GFT/*" >> /etc/systemd/system/atlantis.service
echo "ExecStart=/usr/local/bin/atlantis server" >> /etc/systemd/system/atlantis.service
echo " " >> /etc/systemd/system/atlantis.service
echo "[Install]" >> /etc/systemd/system/atlantis.service
echo "WantedBy=multi-user.target" >> /etc/systemd/system/atlantis.service
echo " " >> /etc/systemd/system/atlantis.service
chmod 664 /etc/systemd/system/atlantis.service

sudo systemctl daemon-reload
sudo systemctl start atlantis
sudo systemctl enable atlantis