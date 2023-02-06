# Windows Redis Monitoring

To monitor a Redis server running on a Windows machine, you can use a combination of Windows Exporter and Prometheus to send metrics to LOGIQ.AI.

This script will help you setup Redis Exporter as a service on a 64-bit Windows Machine and it requires two arguments:

- **PROMETHEUS_CONFIG_PATH**: the path to the Prometheus configuration file.
- **NSSM_PATH**: the path of nssm.exe

Before running the PowerShell script, make sure you have NSSM and Prometheus installed.
To run the PowerShell script, open an `administrator PowerShell` and run the following command:

```powershell
.\redis-exporter-installer.ps1 -NSSM_PATH "<NSSM-path>" -PROMETHEUS_CONFIG_PATH "<Prometheus-configuration-path>"
```

---

After you are done running the script, we have to add a code block in the prometheus.yml file and we have to restart the prometheus service using NSSM.

This code block will rename all the outgoing `redis_...` metrics to `cli_redis_...`.

```yaml
    - action: replace
      source_labels: [__name__]
      regex: 'redis_(.*)'
      target_label: __name__
      replacement: cli_redis_${1}
```

After adding this script your remote_write section must look like this.

> NOTE: Please edit the <LOGIQ-ENDPOINT> and \<HOSTNAME>.

```yaml
remote_write:
  - url: https://<LOGIQ_ENDPOINT>/api/v1/receive
    tls_config:
        insecure_skip_verify: true

    write_relabel_configs:
    - action: replace
      source_labels: [__name__]
      regex: 'redis_(.*)'
      target_label: __name__
      replacement: cli_redis_${1}

    - action: replace
      source_labels: [__name__]
      regex: (.*)
      target_label: instance
      replacement: '<HOSTNAME>'    # has to be replaced with machine hostname
```

> NOTE: Please make sure that replace `redis_(.*)` code block is placed before the `(.*)` regex code block.

Make sure that the script finishes running successfully and the NSSM was able to start the service successfully in the end.
If not, then please check the indentation in the `prometheus.yml` file.

To restart the prometheus service, navigate to the directory where `nssm.exe` file is located.    
Restart the service using these 2 commands: 
```powershell
> $promServiceName = (Get-Service | Where-Object {$_.Name -like "prom*"}).Name
> nssm.exe restart $promServiceName
```