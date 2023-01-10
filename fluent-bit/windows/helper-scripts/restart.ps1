Write-Host "Restarting fluent-bit service..." -ForegroundColor Green
Stop-Service fluent-bit -PassThru
Start-Service fluent-bit -PassThru
