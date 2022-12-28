#  Prometheus windows installer 

Prometheus is a free software application used for event monitoring and alerting. It records real-time metrics in a time series database built using a HTTP pull model, with flexible queries and real-time alerting.
For monitoring Windows with Prometheus, Windows exporter needs to be installed which is the equivalent of Node exporter  for Windows. This exporter will start an HTTP endpoint, exposing metrics which will enable Prometheus to scrape them.
You can run latest MSI installer from the below link, each release provides a .msi installer. The installer will setup the windows_exporter as a Windows service, as well as create an exception in the Windows Firewall.
https://github.com/prometheus-community/windows_exporter/releases

Please follow the below steps to install Prometheus on Windows:
- Download the prometheus.ps1 file or clone the repo
- Powershell by default uses TLS 1.0 to connect to website, but website security requires TLS 1.2, hence run the below.
```
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
```
- By default, Windows does not allow you to execute any scripts due to execution policy set, to enable it, run the below
```
  Get-ExecutionPolicy

  Run Set-ExecutionPolicy like this to switch to the unrestricted mode:

  Set-ExecutionPolicy unrestricted
```
- Execute the below script, the script will download and install Prometheus as a service in the path where the script is executed.
```
   ./windows-prome.ps1
```
- Prometheus service should start running, run the below to check
```
netstat|select-string 9090
```
If you want to add/ modify to enable prometheus to scrape custom endpoint, make the changes on Prometheus.yml file in downloaded prometheus directory and restart the prometheus service

> To enable remote-write on Prometheus, include the remote-write endpoint as shown below in the Prometheus.yml configuration and restart the Prometheus service.

```yaml
remote_write:
  - url: https://<Logiq-endpoint>/api/v1/receive
    tls_config:
      ca_file: <CA-file>
      cert_file: <cert-file>
      key_file: <key-file>
scrape_configs:
  - job_name: prometheus-test6
    metrics_path: '/metrics'
    static_configs:
      - targets: ['localhost:9090']
```