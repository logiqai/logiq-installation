#!/bin/bash

echo "Instal auditd "
sudo apt-get install auditd -y

echo "Add audit rules"
echo "-w /etc/shadow -p wa -k shadow" >> /etc/audit/rules.d/audit.rules
echo "-w /etc/passwd -p wa -k passwd" >> /etc/audit/rules.d/audit.rules

echo "-w /etc/hosts -p wa -k hosts_file_change" >> /etc/audit/rules.d/audit.rules
echo "-w /etc/sysconfig/ -p rwa -k configaccess" >> /etc/audit/rules.d/audit.rules
echo "-w /sbin/iptables -p x -k sbin_susp" >> /etc/audit/rules.d/audit.rules
echo "-w /sbin/ip6tables -p x -k sbin_susp" >> /etc/audit/rules.d/audit.rules
echo "-w /sbin/ifconfig -p x -k sbin_susp" >> /etc/audit/rules.d/audit.rules
echo "-w /usr/bin/wget -p x -k susp_activity" >> /etc/audit/rules.d/audit.rules
echo "-w /usr/bin/curl -p x -k susp_activity" >> /etc/audit/rules.d/audit.rules
echo "-w /usr/bin/base64 -p x -k susp_activity" >> /etc/audit/rules.d/audit.rules
echo "-w /bin/nc -p x -k susp_activity" >> /etc/audit/rules.d/audit.rules
echo "-w /bin/netcat -p x -k susp_activity" >> /etc/audit/rules.d/audit.rules
echo "-w /usr/bin/ncat -p x -k susp_activity" >> /etc/audit/rules.d/audit.rules
echo "-w /usr/bin/ssh -p x -k susp_activity" >> /etc/audit/rules.d/audit.rules
echo "-w /usr/bin/scp -p x -k susp_activity" >> /etc/audit/rules.d/audit.rules
echo "-w /usr/bin/sftp -p x -k susp_activity" >> /etc/audit/rules.d/audit.rules
echo "-w /usr/bin/ftp -p x -k susp_activity" >> /etc/audit/rules.d/audit.rules
echo "-w /usr/bin/socat -p x -k susp_activity" >> /etc/audit/rules.d/audit.rules

echo "-a always,exit -F arch=b32 -S chmod -F auid>=1000 -F auid!=-1 -k perm_mod" >> /etc/audit/rules.d/audit.rules 
echo "-a always,exit -F arch=b32 -S chown -F auid>=1000 -F auid!=-1 -k perm_mod" >> /etc/audit/rules.d/audit.rules 
echo "-a always,exit -F arch=b32 -S fchmod -F auid>=1000 -F auid!=-1 -k perm_mod" >> /etc/audit/rules.d/audit.rules 
echo "-a always,exit -F arch=b32 -S fchmodat -F auid>=1000 -F auid!=-1 -k perm_mod" >> /etc/audit/rules.d/audit.rules 
echo "-a always,exit -F arch=b32 -S fchown -F auid>=1000 -F auid!=-1 -k perm_mod" >> /etc/audit/rules.d/audit.rules 
echo "-a always,exit -F arch=b32 -S fchownat -F auid>=1000 -F auid!=-1 -k perm_mod" >> /etc/audit/rules.d/audit.rules 
echo "-a always,exit -F arch=b32 -S fremovexattr -F auid>=1000 -F auid!=-1 -k perm_mod" >> /etc/audit/rules.d/audit.rules 
echo "-a always,exit -F arch=b32 -S fsetxattr -F auid>=1000 -F auid!=-1 -k perm_mod" >> /etc/audit/rules.d/audit.rules 
echo "-a always,exit -F arch=b32 -S lchown -F auid>=1000 -F auid!=-1 -k perm_mod" >> /etc/audit/rules.d/audit.rules 
echo "-a always,exit -F arch=b32 -S lremovexattr -F auid>=1000 -F auid!=-1 -k perm_mod" >> /etc/audit/rules.d/audit.rules 
echo "-a always,exit -F arch=b32 -S lsetxattr -F auid>=1000 -F auid!=-1 -k perm_mod" >> /etc/audit/rules.d/audit.rules 
echo "-a always,exit -F arch=b32 -S removexattr -F auid>=1000 -F auid!=-1 -k perm_mod" >> /etc/audit/rules.d/audit.rules 
echo "-a always,exit -F arch=b32 -S setxattr -F auid>=1000 -F auid!=-1 -k perm_mod" >> /etc/audit/rules.d/audit.rules 
echo "-a always,exit -F arch=b64 -S chmod  -F auid>=1000 -F auid!=-1 -k perm_mod" >> /etc/audit/rules.d/audit.rules 
echo "-a always,exit -F arch=b64 -S chown -F auid>=1000 -F auid!=-1 -k perm_mod" >> /etc/audit/rules.d/audit.rules 
echo "-a always,exit -F arch=b64 -S fchmod -F auid>=1000 -F auid!=-1 -k perm_mod" >> /etc/audit/rules.d/audit.rules 
echo "-a always,exit -F arch=b64 -S fchmodat -F auid>=1000 -F auid!=-1 -k perm_mod" >> /etc/audit/rules.d/audit.rules 
echo "-a always,exit -F arch=b64 -S fchown -F auid>=1000 -F auid!=-1 -k perm_mod" >> /etc/audit/rules.d/audit.rules 
echo "-a always,exit -F arch=b64 -S fchownat -F auid>=1000 -F auid!=-1 -k perm_mod" >> /etc/audit/rules.d/audit.rules 
echo "-a always,exit -F arch=b64 -S fremovexattr -F auid>=1000 -F auid!=-1 -k perm_mod" >> /etc/audit/rules.d/audit.rules 
echo "-a always,exit -F arch=b64 -S fsetxattr -F auid>=1000 -F auid!=-1 -k perm_mod" >> /etc/audit/rules.d/audit.rules 
echo "-a always,exit -F arch=b64 -S lchown -F auid>=1000 -F auid!=-1 -k perm_mod" >> /etc/audit/rules.d/audit.rules 
echo "-a always,exit -F arch=b64 -S lremovexattr -F auid>=1000 -F auid!=-1 -k perm_mod" >> /etc/audit/rules.d/audit.rules 
echo "-a always,exit -F arch=b64 -S lsetxattr -F auid>=1000 -F auid!=-1 -k perm_mod" >> /etc/audit/rules.d/audit.rules 
echo "-a always,exit -F arch=b64 -S removexattr -F auid>=1000 -F auid!=-1 -k perm_mod" >> /etc/audit/rules.d/audit.rules 
echo "-a always,exit -F arch=b64 -S setxattr -F auid>=1000 -F auid!=-1 -k perm_mod" >> /etc/audit/rules.d/audit.rules

echo "Enabling syslog configuration" 
sed -i 's/active = no/active = yes/' /etc/audit/plugins.d/syslog.conf

sudo systemctl start auditd
