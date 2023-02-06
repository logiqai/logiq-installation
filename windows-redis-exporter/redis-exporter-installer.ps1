param(
    [Parameter(Mandatory=$true)]
    [string]$NSSM_PATH,

    [Parameter(Mandatory=$true)]
    [string]$PROMETHEUS_CONFIG_PATH
)

Write-Host "Values Provided: " -ForegroundColor Green
Write-Host "NSSM_PATH = $NSSM_PATH" -ForegroundColor Green
Write-Host "PROMETHEUS_CONFIG_PATH = $PROMETHEUS_CONFIG_PATH" -ForegroundColor Green

$redisExporterServiceName = "RedisExporterService"

$hostname = hostname
$macAddress = (Get-WmiObject -Class Win32_NetworkAdapter -Filter "NetEnabled='True'").MACAddress
$macAddress = $macAddress -replace ":", ""
$uid = "$hostname-$macAddress"
echo "UID: $uid"


Write-Host "Downloading the Redis exporter..." -ForegroundColor Green
Invoke-WebRequest -Uri https://github.com/oliver006/redis_exporter/releases/download/v1.46.0/redis_exporter-v1.46.0.windows-amd64.zip -OutFile redis_exporter.zip

Write-Host "Extracting..." -ForegroundColor Green
Expand-Archive -Path redis_exporter.zip -DestinationPath .\redis_exporter

$redisExporterFolderPath = ls *redis_exporter-v1.* -Recurse -Directory | Select-String redis_exporter
$redisExecutableName = '\redis_exporter.exe'
$redisExporterExePath = Join-Path $redisExporterFolderPath $redisExecutableName
Write-Host "Path to the redis_exporter.exe: $redisExporterExePath"


# Start the Redis exporter as a NSSM service
Write-Host "Installing the redis exporter..." -ForegroundColor Green
& $NSSM_PATH install $redisExporterServiceName $redisExporterExePath

Start-Sleep -Seconds 2

Write-Host "Setting the AppParameters for Redis Exporter service..." -ForegroundColor Green
& $NSSM_PATH set $redisExporterServiceName AppParameters "--web.listen-address=:9121"

Start-Sleep -Seconds 5

Write-Host "Starting $redisExporterServiceName" -ForegroundColor Green
& $NSSM_PATH start $redisExporterServiceName


Write-Host "Editing the Prometheus scrape_config in $PROMETHEUS_CONFIG_PATH" -ForegroundColor Green
$prometheusConfig = [string[]](Get-Content $PROMETHEUS_CONFIG_PATH)
$redisExporterConfig = @'
  - job_name: 'redis-{0}'
    scrape_interval: 15s
    static_configs:
      - targets: ['localhost:9121']
        labels:
            hostname: '{0}'
            namespace: 'redis-{0}'

'@ -f $uid

$remoteWriteIndex = $prometheusConfig.IndexOf("remote_write:")
$newConfig = [string[]]$prometheusConfig[0..($remoteWriteIndex - 1)] + $redisExporterConfig + [string[]]$prometheusConfig[$remoteWriteIndex..($prometheusConfig.Count - 1)]

# Adding the scrape config change before remote_write to prometheus.yml file
Set-Content $PROMETHEUS_CONFIG_PATH -Value $newConfig

<#
$prometheusConfig1 = [string[]](Get-Content $PROMETHEUS_CONFIG_PATH)
$relabelRedisLabelsConfig = @'
    - action: replace
      source_labels: [__name__]
      regex: 'redis_(.*)'
      target_label: __name__
      replacement: cli_redis_${1}

'@

$writeRelabelConfigIndex = $prometheusConfig1.IndexOf("    write_relabel_configs:")
$newConfig1 = [string[]]$prometheusConfig1[0..($writeRelabelConfigIndex)] + $relabelRedisLabelsConfig + [string[]]$prometheusConfig1[($writeRelabelConfigIndex + 1)..($prometheusConfig1.Count - 1)]

Set-Content $PROMETHEUS_CONFIG_PATH -Value $newConfig1
#>

$promServiceName = (Get-Service | Where-Object {$_.Name -like "prom*"}).Name

Write-Host "Restarting $promServiceName" -ForegroundColor Green
& $NSSM_PATH restart $promServiceName
