# Forwarding Linux audit logs to LOGIQ using Fluent Bit

In order to forward Linux audit logs to LOGIQ by leveraging Fluent Bit, do the following. 

1. Download the `auditd.sh` script from this folder. 
2. Make the script executable by running the following command. 
  ```
  chmod +x auditd.sh
  ```
3. Execute the script by running the following command, this will install auditd and configure the rules required to forward them to Logiq.
  ```
  ./auditd.sh
  ```
4. 
