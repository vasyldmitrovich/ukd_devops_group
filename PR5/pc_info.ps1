# --- РІВЕНЬ 3: ДІАГНОСТИКА ---
Write-Host "=== Завдання Рівень 3 ===" -ForegroundColor Cyan

# 1. Intro (Версія, ПК, Користувач)
$PSVersionTable.PSVersion
$env:COMPUTERNAME
$env:USERNAME

# 2. Variables + Data types
$ComputerName = $env:COMPUTERNAME
$User = $env:USERNAME
$Number = 10
Write-Host "Тип змінної Number: $($Number.GetType().Name)"

# 3. Cmdlets (Процеси та служби)
$procCount = (Get-Process).Count
$svcCount = (Get-Service).Count
Write-Host "Процесів у системі: $procCount"

# 4. Operators (Умова if)
if ($procCount -gt 100) {
    Write-Host "System busy" -ForegroundColor Red
} else {
    Write-Host "System normal" -ForegroundColor Green
}

# 5. Arrays (Масив із 5 процесів)
$Processes = Get-Process | Select-Object -First 5
foreach ($p in $Processes) {
    Write-Host "Процес: $($p.Name)"
}

# 6. Loops (Цикл for від 1 до 5)
for ($i = 1; $i -le 5; $i++) {
    Write-Host "Крок циклу: $i"
}

# 7. HashTable
$PCInfo = @{
    Computer = $ComputerName
    User     = $User
    Date     = Get-Date
}
Write-Host "Дані з HashTable:"
$PCInfo



# --- РІВЕНЬ 4: АНАЛІЗ КЛАСУ ---
Write-Host "`n=== Завдання Рівень 4 ===" -ForegroundColor Magenta

# Масив комп'ютерів (localhost)
$Computers = @("localhost", "127.0.0.1", "UnknownPC")
$Report = @()

foreach ($comp in $Computers) {
    Write-Host "Перевірка зв'язку з $comp..."
    if (Test-Connection -ComputerName $comp -Count 1 -Quiet) {
        # Збираємо дані
        $pCount = (Get-Process).Count
        $mem = Get-CimInstance Win32_OperatingSystem
        $ramUsage = [math]::Round((($mem.TotalVisibleMemorySize - $mem.FreePhysicalMemory) / $mem.TotalVisibleMemorySize) * 100, 2)
        
        $status = "Online"
        if ($ramUsage -gt 70) { $status = "Warning: High RAM usage!" }
        
        $Report += "PC: $comp | Status: $status | RAM: $ramUsage% | Processes: $pCount"
    } else {
        $Report += "PC: $comp | Status: Offline"
    }
}

# Зберігаємо результат у файл
$Report | Out-File "classroom_report.txt"
Write-Host "Звіт 'classroom_report.txt' створено успішно!" -ForegroundColor Green

