Write-Host "=== PC DIAGNOSTICS ==="

Write-Host "`n--- Environment Info ---"
$PSVersionTable.PSVersion
Write-Host "Computer Name: $env:COMPUTERNAME"
Write-Host "User: $env:USERNAME"

Write-Host "`n--- Variables ---"
$ComputerName = $env:COMPUTERNAME
$User = $env:USERNAME
$Number = 10

Write-Host "Type of Number variable:"
$Number.GetType()

Write-Host "`n--- System Info ---"
$procCount = (Get-Process).Count
$serviceCount = (Get-Service).Count

Write-Host "Processes: $procCount"
Write-Host "Services: $serviceCount"

Write-Host "`nOS Info:"
Get-ComputerInfo | Select-Object OSName, OSVersion

Write-Host "`n--- System Load ---"
if ($procCount -gt 100) {
    Write-Host "System busy"
} else {
    Write-Host "System normal"
}

Write-Host "`n--- First 5 Processes ---"
$Processes = Get-Process | Select-Object -First 5

foreach ($p in $Processes) {
    Write-Host $p.Name
}

Write-Host "`n--- Loop (1 to 5) ---"
for ($i = 1; $i -le 5; $i++) {
    Write-Host $i
}

Write-Host "`n--- PC Info (HashTable) ---"
$PCInfo = @{
    Computer = $ComputerName
    User = $User
    Date = Get-Date
}

$PCInfo