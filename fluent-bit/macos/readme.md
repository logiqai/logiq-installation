# Forwarding Linux logs to LOGIQ using Fluent Bit from Mac-OS

In order to forward Mac-OS logs to LOGIQ by leveraging Fluent Bit, do the following. 

1. Use the below commands to install Fluent-bit and Wget
  ```
   brew install fluent-bit
  ```
2. Download the [fluent-bit-macos conf](https://fluent-test-conf.s3.amazonaws.com/fluent-bit-macos.conf) file, rename the file to fluent-bit.conf and add the below section and place it in the /opt/homebrew/Cellar/fluent-bit/1.8.7/etc/fluent-bit/ installation location.
```
For https endpoint, use the below.

    [OUTPUT]
        name     http
        match    *
        host     <Logiq endpoint>
        port     443
        URI      /v1/json_batch
        Format   json
        tls      on
        tls.verify  off
        net.keepalive  off
        compress      gzip
        Header Authorization Bearer <token>

For http endpoint, use the below
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
3. In the parsers file(/opt/homebrew/Cellar/fluent-bit/1.8.7/etc/fluent-bit/parsers.conf), add the below to parse the log lines streaming from Mac-OS.
```
   [PARSER] 
       Name        syslog-mac
       Format      regex
       Regex       (?<time>[^ ]* {1,2}[^ ]* [^ ]*) (?<ident>[a-zA-Z0-9_\/\.\-]*)(?:\[(?<pid>[0-9]+)\])?(?:[^\:]*\:)? *(?<message>.*)$
       Time_Key    time
       Time_Format %b %d %H:%M:%S
       Time_Keep   On
```
4. please verify the installation path and run fluent-bit using the below command.
```
/opt/homebrew/bin/fluent-bit -c /opt/homebrew/Cellar/fluent-bit/1.8.7/etc/fluent-bit/fluent-bit.conf >> /tmp/fluent.log 2>&1 &
```
5. If you intend to make Fluent-bit a service. Go to Finder -> Automator -> Application
   <img width="542" alt="Screenshot 2021-09-28 at 3 44 50 PM" src="https://user-images.githubusercontent.com/67860971/135069875-735cf52d-4a25-4985-9826-c31d9283353c.png">
6. Copy paste the from the installation folder and create an application.

<img width="1358" alt="Screenshot 2021-09-28 at 3 48 49 PM" src="https://user-images.githubusercontent.com/67860971/135070235-5ce808e6-d462-404f-81a3-b9c0f9e4eaef.png">

8. Navigate to System preferences -> Users & Groups -> Login Items -> Select the script from above.
<img width="669" alt="Screenshot 2021-09-28 at 3 50 56 PM" src="https://user-images.githubusercontent.com/67860971/135070273-b930def1-000a-4a2f-bca7-c43f4f682115.png">


You should now see your macOS logs being ingested into the `macOS:macOS` namespace on your LOGIQ UI. 
