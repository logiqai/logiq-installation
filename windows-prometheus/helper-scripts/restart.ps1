Write-Host "Restarting Prometheus service..." -ForegroundColor Yellow
Stop-Service prometheus1 -PassThru
Start-Service prometheus1 -PassThru