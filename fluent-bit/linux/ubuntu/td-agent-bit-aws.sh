#!/bin/bash
set -x
code_name=`lsb_release -a|grep -i codename`
cleaned_code=`echo $code_name| cut -d':' -f2|sed 's/ //g'`


focal_entry="deb https://packages.fluentbit.io/ubuntu/focal focal main"
bionic_entry="deb https://packages.fluentbit.io/ubuntu/bionic bionic main"
xenial_entry="deb https://packages.fluentbit.io/ubuntu/xenial xenial main"
filename="/etc/apt/sources.list"
echo "Acquire::https::packages.fluentbit.io::Verify-Peer \"false\";" >> /etc/apt/apt.conf.d/99influxdata-cert
wget -qO - https://packages.fluentbit.io/fluentbit.key | sudo apt-key add -
if [[ "$cleaned_code" =~ .*"focal".* ]]; then
  echo "Ubuntu Focal."
  echo $focal_entry >> $filename
elif [[ "$cleaned_code" =~ .*"bionic".* ]]; then
   echo "Ubuntu Bionic"
   echo $bionic_entry >> $filename
elif [[ "$cleaned_code" =~ .*"xenial".* ]]; then
   echo "Ubuntu Xenial "
   echo $xenial_entry >> $filename
fi

sudo apt-get update -y
sudo apt-get install td-agent-bit -y --allow-unauthenticated
wget https://fluent-test-conf.s3.amazonaws.com/fluent-bit-linux.conf
sed -i "s/<Token>/$MY_TOKEN/g" fluent-bit-linux.conf
sed -i "s/<logiq endpoint>/$LOGIQ/g" fluent-bit-linux.conf
mv fluent-bit-linux.conf /etc/td-agent-bit/td-agent-bit.conf
echo "*.* action(type=\"omfwd\"
           queue.type=\"LinkedList\"
           action.resumeRetryCount=\"-1\"
           queue.size=\"10000\"
           queue.saveonshutdown=\"on\"
           target=\"127.0.0.1\" Port=\"5140\" Protocol=\"tcp\"
           )">>/etc/rsyslog.conf
