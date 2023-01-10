Write-Host "Uninstalling fluent-bit..." -ForegroundColor Red
Stop-Service fluent-bit -PassThru
C:\Windows\System32\sc.exe delete fluent-bit
rm ./td-agent-bit-1.8.6-win64
rm td-agent-bit.zip
