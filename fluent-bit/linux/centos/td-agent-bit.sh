#!/bin/sh

echo "[td-agent-bit]
name = TD Agent Bit
baseurl = https://packages.fluentbit.io/centos/7/\$basearch/
gpgcheck=1
gpgkey=https://packages.fluentbit.io/fluentbit.key
enabled=1" >> /etc/yum.repos.d/td-agent-bit.repo

yum install td-agent-bit -y
