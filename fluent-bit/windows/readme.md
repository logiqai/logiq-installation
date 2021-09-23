Windows logs to Logiq.

- Check your connectivity to your cluster by sending a http payload to your client using the below curl command on Windows
- Launch your Powershell and execute the below to set variables. Please ensure to change the "@timestamp" below to match the current date and time.
```
   $body = @{"message"="LOGIQ Json services are up"
         "@timestamp"="2021-09-23T06:25:18Z"
         "host"="curl_host"
         "proc_id"="json-batch-test"
         "app_name"="curl"
         "namespace"="windows-curl-namespace"
         "cluster_id"="logiq-json-batch-test"
} | ConvertTo-Json

$header = @{
 "Accept"="application/json"
 "Authorization"="Bearer <token>"
 "Content-Type"="application/json"
} 
```
- Execute the below method to send the payload to your logiq endpoint.
```
Invoke-RestMethod -Uri " https://<logiq endpoint>/v1/json_batch" -Method 'Post' -Body $body -Headers $header | ConvertTo-HTML
```
- Download the repository
- Create a temporary folder (D:/test)
- Navigate to folder created
- Download fluent-bit.conf file in the same folder from docs.logiq.ai(https://docs.logiq.ai/logiq-server/agentless#fluent-bit-for-windows) and configure the output to your own Logiq cluster.
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
