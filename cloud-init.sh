#!/bin/bash
sudo apt update -y

# Install Docker
sudo apt install -y docker.io
sudo systemctl enable docker
sudo systemctl start docker

# Install Docker Compose
sudo apt install -y docker-compose
sudo usermod -aG docker $USER

## Install Grafana

sudo apt-get install -y apt-transport-https wget -y
sudo mkdir -p /etc/apt/keyrings/
wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/grafana.gpg > /dev/null
echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com beta main" | sudo tee -a /etc/apt/sources.list.d/grafana.list

sudo apt-get update
sudo apt-get install grafana -y

sudo systemctl enable grafana-server
sudo systemctl start grafana-server


## Install Prometheus

sudo apt-get update -y
sudo apt-get install -y wget curl tar
sudo useradd --no-create-home --shell /bin/false prometheus

sudo mkdir /etc/prometheus
sudo mkdir /var/lib/prometheus

PROM_VERSION="3.5.1"

echo "Downloading Prometheus version $PROM_VERSION..."
wget https://github.com/prometheus/prometheus/releases/download/v$PROM_VERSION/prometheus-$PROM_VERSION.linux-amd64.tar.gz

# Extract Prometheus tarball
echo "Extracting Prometheus..."
tar -xvzf prometheus-$PROM_VERSION.linux-amd64.tar.gz

# Move Prometheus binaries to appropriate locations
echo "Moving Prometheus binaries..."
sudo mv prometheus-$PROM_VERSION.linux-amd64/prometheus /usr/local/bin/
sudo mv prometheus-$PROM_VERSION.linux-amd64/promtool /usr/local/bin/

# Set ownership of the Prometheus binary and directories

echo "Setting ownership of Prometheus files..."

sudo chown prometheus:prometheus /usr/local/bin/prometheus
sudo chown prometheus:prometheus /usr/local/bin/promtool
sudo chown -R prometheus:prometheus /etc/prometheus
sudo chown -R prometheus:prometheus /var/lib/prometheus

# Clean up downloaded files

echo "Cleaning up downloaded files..."
rm -rf prometheus-$PROM_VERSION.linux-amd64*
  
# Create Prometheus configuration file

echo "Creating Prometheus configuration file..."

cat <<EOL | sudo tee /etc/prometheus/prometheus.yml
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']
  - job_name: 'node_exporter'
    static_configs:
      - targets: ['localhost:9100']      
EOL

# Create Prometheus systemd service file
echo "Creating Prometheus systemd service..."
cat <<EOL | sudo tee /etc/systemd/system/prometheus.service
[Unit]
Description=Prometheus
After=network.target

[Service]
User=prometheus
Group=prometheus
ExecStart=/usr/local/bin/prometheus --config.file=/etc/prometheus/prometheus.yml --storage.tsdb.path=/var/lib/prometheus/

[Install]
WantedBy=multi-user.target
EOL

# Reload systemd to pick up the new Prometheus service
echo "Reloading systemd..."

# Enable and start the Prometheus service
echo "Enabling and starting Prometheus..."

sudo systemctl enable prometheus
sudo systemctl start prometheus


## Install Node Exporter

sudo useradd -rs /bin/false node_exporter
wget https://github.com/prometheus/node_exporter/releases/download/v1.10.2/node_exporter-1.10.2.linux-amd64.tar.gz
tar -xvf node_exporter-1.10.2.linux-amd64.tar.gz
cp node_exporter-1.10.2.linux-amd64/node_exporter /usr/local/bin/

cat <<EOF > /etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter
After=network.target

[Service]
User=node_exporter
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=default.target
EOF

sudo systemctl enable node_exporter
sudo systemctl start node_exporter