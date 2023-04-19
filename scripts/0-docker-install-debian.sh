#/bin/bash

sudo apt update
sudo apt install -y docker.io

echo "%${USER} ALL=(ALL) NOPASSWD: /usr/bin/dockerd" | sudo EDITOR='tee ' visudo --quiet --file=/etc/sudoers.d/passwordless-docker

tee -a ~/.bashrc <<EOF
# Starting Docker daemon automatically if not running...' >> ~/.bashrc
'RUNNING=`ps aux | grep dockerd | grep -v grep`' >> ~/.bashrc
'if [ -z "$RUNNING" ]; then' >> ~/.bashrc
'    sudo dockerd > /dev/null 2>&1 &' >> ~/.bashrc
'    disown' >> ~/.bashrc
'fi'
EOF

sudo usermod -a -G docker $USER

# Workaround required for Debian nftables, as Docker uses legacy iptables
sudo update-alternatives --set iptables /usr/sbin/iptables-legacy
sudo update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy

# Install docker compose v2
sudo mkdir -p /usr/local/lib/docker/cli-plugins
sudo curl -SL https://github.com/docker/compose/releases/download/v2.17.2/docker-compose-linux-x86_64 -o /usr/local/lib/docker/cli-plugins/docker-compose
sudo chmod +x /usr/local/lib/docker/cli-plugins/docker-compose
