Write-Host "Restarting fluent-bit service..." -BackgroundColor Green -ForegroundColor White
Stop-Service fluent-bit -PassThru
Start-Service fluent-bit -PassThru
