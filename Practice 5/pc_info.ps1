# --- 1. Intro: Перевірка середовища ---
Write-Host "=== Діагностика комп'ютера ===" -ForegroundColor Cyan
Write-Host "Версія PowerShell: $($PSVersionTable.PSVersion)"
Write-Host "Ім'я комп'ютера: $env:COMPUTERNAME"
Write-Host "Поточний користувач: $env:USERNAME"

# --- 2. Variables + Data types ---
$ComputerName = $env:COMPUTERNAME
$User = $env:USERNAME
$Number = 10

Write-Host "`nТип змінної `$Number:" -ForegroundColor Yellow
$Number.GetType() | Format-Table Name, BaseType

# --- 3. Cmdlets: Збір інформації ---
$procCount = (Get-Process).Count
$servCount = (Get-Service).Count
$osInfo = Get-ComputerInfo | Select-Object OsName, OsVersion

Write-Host "`nЗапущено процесів: $procCount"
Write-Host "Кількість служб: $servCount"
Write-Host "ОС: $($osInfo.OsName) (Версія: $($osInfo.OsVersion))"

# --- 4. Operators: Умови ---
Write-Host "`nСтатус системи:" -ForegroundColor Yellow
if ($procCount -gt 100) {
    Write-Host "System busy (Процесів більше 100)" -ForegroundColor Red
} else {
    Write-Host "System normal (Процесів менше 100)" -ForegroundColor Green
}

# --- 5. Arrays: Масиви ---
Write-Host "`nТоп 5 процесів:" -ForegroundColor Yellow
$Processes = Get-Process | Select-Object -First 5
foreach ($p in $Processes) {
    Write-Host "- $($p.Name) (ID: $($p.Id))"
}

# --- 6. Loops: Цикли ---
Write-Host "`nРахуємо від 1 до 5 (цикл for):" -ForegroundColor Yellow
for ($i = 1; $i -le 5; $i++) {
    Write-Host "Число: $i"
}

# --- 7. HashTable: Хеш-таблиця (Словник) ---
Write-Host "`nХеш-таблиця з даними:" -ForegroundColor Yellow
$PCInfo = @{
    Computer = $ComputerName
    User = $User
    Date = Get-Date
}

# Вивід хеш-таблиці
$PCInfo | Format-Table -AutoSize