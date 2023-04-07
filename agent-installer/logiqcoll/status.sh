#!/usr/bin/bash
sudo systemctl status fluent-bit.service
sudo systemctl status prometheus.service
sudo systemctl status prometheus-node-exporter.service
sudo systemctl status wazuh-agent.service
sudo systemctl status td-agent-bit.service
