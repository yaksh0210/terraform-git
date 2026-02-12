#!/bin/bash
apt update -y

# Install Docker
apt install -y docker.io
systemctl enable docker
systemctl start docker

# Install Docker Compose
apt install -y docker-compose

## Install Grafana

sudo apt-get install -y apt-transport-https wget -y
sudo mkdir -p /etc/apt/keyrings/
wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/grafana.gpg > /dev/null
echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com beta main" | sudo tee -a /etc/apt/sources.list.d/grafana.list

sudo apt-get update
sudo apt-get install grafana -y

systemctl enable grafana-server
systemctl start grafana-server


## Install Prometheus



## Install Node Exporter

# useradd -rs /bin/false node_exporter
# wget https://github.com/prometheus/node_exporter/releases/download/v1.10.2/node_exporter-1.10.2.linux-amd64.tar.gz
# tar -xvf node_exporter-1.10.2.linux-amd64.tar.gz
# cp node_exporter-1.10.2.linux-amd64/node_exporter /usr/local/bin/

# cat <<EOF > /etc/systemd/system/node_exporter.service
# [Unit]
# Description=Node Exporter
# After=network.target

# [Service]
# User=node_exporter
# ExecStart=/usr/local/bin/node_exporter

# [Install]
# WantedBy=default.target
# EOF

# systemctl daemon-reload
# systemctl enable node_exporter
# systemctl start node_exporter