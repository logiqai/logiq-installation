#!/bin/sh
root_space=`df -h  ./|awk '{print $4}'|sed s/G//g|tail -1`
echo $root_space
if [ $root_space -gt 250 ] 
then
   core=`lscpu|awk '/CPU\(s\)/{print $2}'|head -1`
   if [ $core -gt 7 ]
   then
      echo " CPU cores more than 8 "
      sudo apt-get update -y
      sudo apt install ansible -y
      version=`ansible --version|head -1 |awk '/ansible/{print $2}'|sed 's/\.//g'|sed "s/^0*\([1-9]\)/\1/; s/'/^/"`
      if [ $version -gt 0 ]
      then 
          echo "ansible installed "
          ansible-playbook logiq-playbook.yaml
      fi
   else
      echo "Need a minimum of 8 cores "
   fi
else
   echo "Need a minimum of 250G disk space \n"
fi

wget https://github.com/logiqai/logiqctl/releases/download/logiqctl-2.1.5/logiqctl_linux_amd64 
wget https://fluent-test-conf.s3.amazonaws.com/logiq-monitoring.json   
wget https://fluent-test-conf.s3.amazonaws.com/logs-overview.json  
wget https://fluent-test-conf.s3.amazonaws.com/logflow1.json 
wget https://fluent-test-conf.s3.amazonaws.com/logflow2.json
sudo chmod 777 logiqctl_linux_amd64
