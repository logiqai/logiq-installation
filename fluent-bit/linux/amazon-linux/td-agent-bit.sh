#!/bin/sh

echo " Installing fluent-bit"

echo "[td-agent-bit]
name = TD Agent Bit
baseurl = https://packages.fluentbit.io/amazonlinux/2/\$basearch/
gpgcheck=1
gpgkey=https://packages.fluentbit.io/fluentbit.key
enabled=1" >>/etc/yum.repos.d/td-agent-bit.repo
yum install td-agent-bit -y

echo "Installing fluent conf and omrelp conf"

if [ $1 = "http" ]
then
   wget https://fluent-test-conf.s3.amazonaws.com/fluent-bit-linux-http.conf
   sudo  mv fluent-bit-linux-http.conf fluent-bit-linux.conf
else
   wget https://fluent-test-conf.s3.amazonaws.com/fluent-bit-linux.conf
fi


if [ -z "$MY_TOKEN" ]
then
   echo "Logiq_token not set"
else
   sed -i "s/<Token>/$MY_TOKEN/g" fluent-bit-linux.conf
fi

if [ -z "$LOGIQ" ]
then
   echo "Logiq endpoint not set"
else
   sed -i "s/<logiq endpoint>/$LOGIQ/g" fluent-bit-linux.conf
fi

sudo mv fluent-bit-linux.conf /etc/td-agent-bit/td-agent-bit.conf
#wget https://fluent-test-conf.s3.amazonaws.com/fluent-bit-linux.conf
#mv fluent-bit-linux.conf /etc/td-agent-bit/td-agent-bit.conf
echo "*.* action(type=\"omfwd\"
           queue.type=\"LinkedList\"
           action.resumeRetryCount=\"-1\"
           queue.size=\"10000\"
           queue.saveonshutdown=\"on\"
           target=\"127.0.0.1\" Port=\"5140\" Protocol=\"tcp\"
           )">>/etc/rsyslog.conf

sudo systemctl restart rsyslog
sudo systemctl restart td-agent-bit
