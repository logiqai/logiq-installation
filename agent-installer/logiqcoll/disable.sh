#!/usr/bin/bash
systemctl stop prometheus.service
systemctl stop prometheus-node-exporter.service
systemctl stop td-agent-bit.service
systemctl stop fluent-bit.service
systemctl stop wazuh-agent.service

systemctl disable prometheus.service
systemctl disable prometheus-node-exporter.service
systemctl disable td-agent-bit.service
systemctl disable fluent-bit.service
systemctl disable wazuh-agent.service
