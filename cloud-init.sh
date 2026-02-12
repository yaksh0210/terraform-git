#!/bin/bash
apt update -y

# Install Docker
apt install -y docker.io
systemctl enable docker
systemctl start docker

# Install Docker Compose
apt install -y docker-compose

# # Install Node Exporter
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

# # Install Prometheus
# apt install -y prometheus
# systemctl enable prometheus
# systemctl start prometheus

# # Install Grafana
# apt install -y apt-transport-https software-properties-common
# wget -q -O - https://packages.grafana.com/gpg.key | apt-key add -
# add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"
# apt update -y
# apt install -y grafana
# systemctl enable grafana-server
# systemctl start grafana-server
