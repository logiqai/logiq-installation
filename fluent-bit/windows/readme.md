Windows logs to Logiq.

- Download the repository
- Create a temporary folder (D:/test)
- Navigate to folder created
- Download fluent-bit.conf file in the same folder from docs.logiq.ai and configure the output to your own Logiq cluster.
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
- By default, Windows does not allow you to execute any scripts due to execution policy set, you want to enable it, by running the below
```
  Get-ExecutionPolicy

  Run Set-ExecutionPolicy like this to switch to the unrestricted mode:

  Set-ExecutionPolicy unrestricted
```
- Navigate to Windows -> Open power-Shell and run it in Admin mode.
- Execute the script 
 ```
 Output:
 PS D:\test> .\fluentbit-install.ps1
 [SC] CreateService SUCCESS
 The fluent-bit service is starting.
 The fluent-bit service was started successfully.
```

-  Windows -> Run -> services.msc  you should see a Fluent-bit service running

![Windows](https://user-images.githubusercontent.com/67860971/132339749-43cd8404-ba6a-412e-911a-00b1b9e07fd5.png)
