Write-Host "Downloading Prometheus ..." -BackgroundColor Green -ForegroundColor White
Invoke-WebRequest 'https://github.com/prometheus/prometheus/releases/download/v2.36.0/prometheus-2.36.0.windows-amd64.zip'  -OutFile prome.zip
Expand-Archive -Path prome.zip -DestinationPath .
$path=ls  *prome* -Recurse  -Directory|Select-String prometheus
$conf='\prometheus.yml'
$confpath1=Join-Path $path $conf
$appendbin2='\prometheus.exe'
$binpath2=Join-Path $path $appendbin2

#Write-Output $confpath1
#Write-Output $binpath2
Invoke-WebRequest 'https://nssm.cc/release/nssm-2.24.zip' -OutFile nssm.zip
Expand-Archive -Path nssm.zip -DestinationPath .
$nssmpath=ls  *nssm* -Recurse  -Directory|Select-String nssm
$nssm='\win64'
$confpath2=Join-Path $nssmpath $nssm
cd $confpath2
#Write-Output $confpath2
#Write-Output $binpath2
.\nssm install prometheus1 $binpath2
.\nssm.exe set prometheus1 AppParameters "--config.file=$confpath1"
