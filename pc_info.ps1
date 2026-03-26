# --- Intro ---
Write-Host "--- ПЕРЕВІРКА СЕРЕДОВИЩА ---" -ForegroundColor Cyan
$PSVersionTable.PSVersion
Write-Host "Комп'ютер: $env:COMPUTERNAME"
Write-Host "Користувач: $env:USERNAME"

# --- Variables + Data types ---
$ComputerName = $env:COMPUTERNAME
$User = $env:USERNAME
$Number = 10
Write-Host "`nТип змінної `$Number: $($Number.GetType().Name)"

# --- Cmdlets ---
$procCount = (Get-Process).Count
$svcCount = (Get-Service).Count
Write-Host "`nПроцесів: $procCount"
Write-Host "Служб: $svcCount"

# --- Operators ---
if ($procCount -gt 100) {
    Write-Host "System busy" -ForegroundColor Red
} else {
    Write-Host "System normal" -ForegroundColor Green
}

# --- Arrays ---
Write-Host "`n--- Список 5 процесів ---" -ForegroundColor Yellow
$Processes = Get-Process | Select-Object -First 5
foreach ($p in $Processes) {
    Write-Host "Назва: $($p.Name)"
}

# --- Loops ---
Write-Host "`n--- Цикл FOR ---"
for ($i = 1; $i -le 5; $i++) {
    Write-Host "Число: $i"
}

# --- HashTable ---
$PCInfo = @{
    Computer = $ComputerName
    User = $User
    Date = Get-Date
}
Write-Host "`n--- HashTable Info ---"
$PCInfo
