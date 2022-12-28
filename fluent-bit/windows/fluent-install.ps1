Write-Host "Downloading Fluent Bit ..." -BackgroundColor Green -ForegroundColor White
Invoke-WebRequest 'https://fluentbit.io/releases/1.8/td-agent-bit-1.8.6-win64.zip'  -OutFile td-agent-bit.zip
Expand-Archive -Path td-agent-bit.zip -DestinationPath .
$path=ls  *td* -Recurse  -Directory|Select-String td-agent
$conf='\conf'
$confpath1=Join-Path $path $conf
Copy-Item "fluent-bit.conf" -Destination $confpath1

$appendbin='\bin\fluent-bit.exe'
$binpath=Join-Path $path $appendbin
$appendconf='\conf\fluent-bit.conf'
$confpath=Join-Path $path $appendconf

sc.exe create fluent-bit binpath= "$binpath -c $confpath" start= auto
net start fluent-bit