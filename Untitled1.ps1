# pc_info.ps1

# Intro — перевірка середовища
Write-Host "--- Intro ---" -ForegroundColor Cyan
$PSVersionTable.PSVersion
$env:COMPUTERNAME
$env:USERNAME

# Variables + Data types
$ComputerName = $env:COMPUTERNAME
$User = $env:USERNAME
$Number = 10
Write-Host "Тип змінної `$Number:" -NoNewline
[cite_start]$Number.GetType().Name # Використання GetType() як у 

# Cmdlets
$procCount = (Get-Process).Count
$svcCount = (Get-Service).Count
$osInfo = Get-ComputerInfo | Select-Object OsName, OsVersion

Write-Host "`nПроцесів: $procCount"
Write-Host "Служб: $svcCount"

# Operators
if ($procCount -gt 172) {
    Write-Host "System busy" -ForegroundColor Red
} else {
    Write-Host "System normal" -ForegroundColor Green
}

# Arrays
$Processes = Get-Process | Select-Object -First 5
Write-Host "`n--- Список 5 процесів ---"
foreach ($p in $Processes) {
    $p.Name
}

# Loops
Write-Host "`n--- Цикл for (1..5) ---"
for ($i = 1; $i -le 5; $i++) {
    Write-Host "Число: $i"
}

# HashTable
$PCInfo = @{
    Computer = $ComputerName
    User = $User
    Date = Get-Date
}
Write-Host "`n--- HashTable Info ---"
$PCInfo