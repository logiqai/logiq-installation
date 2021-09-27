#!/bin/sh

echo "[td-agent-bit]
name = TD Agent Bit
baseurl = https://packages.fluentbit.io/centos/7/\$basearch/
gpgcheck=1
gpgkey=https://packages.fluentbit.io/fluentbit.key
enabled=1" >> /etc/yum.repos.d/td-agent-bit.repo

yum install td-agent-bit -y

wget https://fluent-test-conf.s3.amazonaws.com/fluent-bit-linux.conf
mv fluent-bit-linux.conf /etc/td-agent-bit/td-agent-bit.conf
echo "*.* action(type=\"omfwd\"
           queue.type=\"LinkedList\"
           action.resumeRetryCount=\"-1\"
           queue.size=\"10000\"
           queue.saveonshutdown=\"on\"
           target=\"127.0.0.1\" Port=\"5140\" Protocol=\"tcp\"
           )">>/etc/rsyslog.conf
