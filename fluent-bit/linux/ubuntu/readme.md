# Forwarding Linux logs to LOGIQ using Fluent Bit

In order to forward Linux logs to LOGIQ by leveraging Fluent Bit, do the following. 

1. Download the `td-agent-bit.sh` script from this folder. 
2. Make the script executable by running the following command. 
  ```
  chmod +x td-agent-bit.sh
  ```
3. Execute the script by running the following command.
  ```
  sudo ./td-agent-bit.sh
  
  or
  
  sudo bash td-agent-bit.sh
  ```

The script execution carries out the following:
- Installs Fluent Bit
- Checks your OS versions and updates your sources list, as mentioned in the [Fluent Bit documentation](https://docs.fluentbit.io/manual/installation/linux/ubuntu#update-your-sources-lists). 
- Configures Rsyslog to add `omfwd`, as shown below.
  ```
  *.* action(type="omfwd"
           queue.type="LinkedList"
           action.resumeRetryCount="-1"
           queue.size="10000"
           queue.saveonshutdown="on"
           target="127.0.0.1" Port="5140" Protocol="tcp"
           )
  ```
  
The script also places the `td-agent-bit.conf` file under the default Fluent Bit installation folder `/etc/td-agent-bit`. Configure the `[OUTPUT]` section of the `td-agent-bit.conf` file based on your LOGIQ cluster, as shown below. 
  
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

Now that the configuration is complete, run the following commands to start Fluent Bit and Rsyslog.
```
systemctl start td-agent-bit
systemctl restart rsyslog
```

You should now see your Linux logs being ingested into the `Linux:Linux1` namespace on your LOGIQ UI. 

![linux](https://user-images.githubusercontent.com/67860971/133257871-58663332-995c-4849-9638-8fe96826296a.png)

