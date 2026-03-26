
Write-Host "--- Рівень 3: Діагностика ПК ---" -ForegroundColor Cyan
$ComputerName = $env:COMPUTERNAME
$User = $env:USERNAME
$Number = 10
Write-Host "PowerShell Version: $($PSVersionTable.PSVersion)"
Write-Host "Computer Name: $ComputerName"
Write-Host "Current User: $User"
Write-Host "Variable Number type: $($Number.GetType().Name)"
$procCount = (Get-Process).Count
$svcCount = (Get-Service).Count
Write-Host "Processes: $procCount | Services: $svcCount"
if ($procCount -gt 100) {
    Write-Host "System status: System busy" -ForegroundColor Red
} else {
    Write-Host "System status: System normal" -ForegroundColor Green
}
$Processes = Get-Process | Select-Object -First 5
Write-Host "Top 5 processes:"
foreach ($p in $Processes) {
    Write-Host " - $($p.Name)"
}
Write-Host "Counting 1 to 5:"
for ($i=1; $i -le 5; $i++) {
    Write-Host " Number: $i"
}
$PCInfo = @{
    Computer = $ComputerName
    User     = $User
    Date     = Get-Date
}
Write-Host "`nHashTable Content:" -ForegroundColor Yellow
$PCInfo

