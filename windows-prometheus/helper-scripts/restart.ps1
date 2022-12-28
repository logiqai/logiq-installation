Write-Host "Restarting Prometheus service..." -BackgroundColor Yellow -ForegroundColor White
Stop-Service prometheus1 -PassThru
Start-Service prometheus1 -PassThru