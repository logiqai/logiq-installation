Write-Host "Uninstalling prometheus service..." -ForegroundColor Red
Stop-Service prometheus1 -PassThru
C:\Windows\System32\sc.exe delete prometheus1