#!/bin/sh

echo " creating node exporter user and installing node exp \n"

sudo useradd --no-create-home node_exporter
wget https://github.com/prometheus/node_exporter/releases/download/v1.0.1/node_exporter-1.0.1.linux-amd64.tar.gz
tar xzf node_exporter-1.0.1.linux-amd64.tar.gz
sudo cp node_exporter-1.0.1.linux-amd64/node_exporter /usr/local/bin/node_exporter
rm -rf node_exporter-1.0.1.linux-amd64.tar.gz node_exporter-1.0.1.linux-amd64

echo " creating node expo service \n"
echo "[Unit]
Description=Prometheus Node Exporter Service
After=network.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target" >>/etc/systemd/system/node-exporter.service

echo " Starting fluent-bit \n"
sudo systemctl daemon-reload
sudo systemctl enable node-exporter
sudo systemctl start node-exporter


echo " Installing fluent-bit"

echo "[td-agent-bit]
name = TD Agent Bit
baseurl = https://packages.fluentbit.io/amazonlinux/2/\$basearch/
gpgcheck=1
gpgkey=https://packages.fluentbit.io/fluentbit.key
enabled=1" >>/etc/yum.repos.d/td-agent-bit.repo
yum install td-agent-bit -y

echo "Installing fluent conf and omrelp conf"
#wget https://fluent-test-conf.s3.amazonaws.com/fluent-bit-linux.conf
#mv fluent-bit-linux.conf /etc/td-agent-bit/td-agent-bit.conf
echo "*.* action(type=\"omfwd\"
           queue.type=\"LinkedList\"
           action.resumeRetryCount=\"-1\"
           queue.size=\"10000\"
           queue.saveonshutdown=\"on\"
           target=\"127.0.0.1\" Port=\"5140\" Protocol=\"tcp\"
           )">>/etc/rsyslog.conf
