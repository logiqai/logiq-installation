Write-Host "Uninstalling prometheus service..." -BackgroundColor Red -ForegroundColor White
Stop-Service prometheus1 -PassThru
C:\Windows\System32\sc.exe delete prometheus1