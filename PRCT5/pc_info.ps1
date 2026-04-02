Write-Host "--- 1. Intro ---" -ForegroundColor Cyan
$PSVersionTable.PSVersion
$env:COMPUTERNAME
$env:USERNAME

Write-Host "`n--- 2. Variables ---" -ForegroundColor Cyan
$Number = 10
Write-Host "Variable type of `$Number: $($Number.GetType().Name)"

Write-Host "`n--- 3. Cmdlets ---" -ForegroundColor Cyan
$procCount = (Get-Process).Count
$servCount = (Get-Service).Count
Write-Host "Processes: $procCount, Services: $servCount"

Write-Host "`n--- 4. Operators ---" -ForegroundColor Cyan
if ($procCount -gt 100) { "System busy" } else { "System normal" }

Write-Host "`n--- 5. Arrays ---" -ForegroundColor Cyan
$Processes = Get-Process | Select-Object -First 5
foreach ($p in $Processes) { $p.Name }

Write-Host "`n--- 6. Loops (For) ---" -ForegroundColor Cyan
for ($i = 1; $i -le 5; $i++) { "Number: $i" }

Write-Host "`n--- 7. HashTable ---" -ForegroundColor Cyan
$PCInfo = @{ Computer = $env:COMPUTERNAME; User = $env:USERNAME; Date = Get-Date }
$PCInfo