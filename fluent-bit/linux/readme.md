- Download the script
- Grant execute permissions to the script
```
  chmod +x td-agent-bit.sh
```
- Execute the script 
```
  ./td-agent-bit.sh
```
   - script will do the below
     - Install fluent-bit
     - Checks your OS-versiona and updates the sources.list as per https://docs.fluentbit.io/manual/installation/linux/ubuntu  
     - Rsyslog will be configured to add omfwd as below.
     ```
       *.* action(type="omfwd"
           queue.type="LinkedList"
           action.resumeRetryCount="-1"
           queue.size="10000"
           queue.saveonshutdown="on"
           target="127.0.0.1" Port="5140" Protocol="tcp"
           )
     ```
- td-agent-bit.conf has been placed under /etc/td-agent-bit (default fluent-bit installation folder), configure the td-agent-bit.conf output to your own Logiq cluster.
```
  [OUTPUT]
    Name          http
    Match         *
    Host          localhost
    Port          80
    URI           /v1/json_batch
    Format        json
    tls           off
    tls.verify    off
    net.keepalive off
    compress      gzip
    Header Authorization Bearer ${LOGIQ_TOKEN}
```
- Run the below to start fluent-bit and rsyslog after the config changes
```
  systemctl start td-agent-bit
  systemctl restart rsyslog
```
- you should see Logs load up in the Linux:Linux1 namespace on Logiq.
![linux](https://user-images.githubusercontent.com/67860971/133257871-58663332-995c-4849-9638-8fe96826296a.png)

