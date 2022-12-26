Write-Host "Stopping fluent-bit service..." -BackgroundColor Red -ForegroundColor White
Stop-Service fluent-bit -PassThru
