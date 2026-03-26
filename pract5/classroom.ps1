# 1. Створюємо масив із 5 комп’ютерів
$Computers = @($env:COMPUTERNAME, "127.0.0.1", "localhost", "PC-Admin", "PC-Lab01")

$Report = @()

foreach ($pc in $Computers) {
    Write-Host "`nChecking $pc..." -ForegroundColor Cyan

    if (Test-Connection -ComputerName $pc -Count 1 -Quiet) {
        Write-Host "$pc is ONLINE" -ForegroundColor Green

        # Визначаємо, чи це локальний комп'ютер, щоб уникнути помилок доступу
        $isLocal = ($pc -eq $env:COMPUTERNAME -or $pc -eq "localhost" -or $pc -eq "127.0.0.1")

        # 3. Отримуємо кількість процесів
        if ($isLocal) {
            $procCount = (Get-Process).Count
        } else {
            $procCount = (Get-Process -ComputerName $pc -ErrorAction SilentlyContinue).Count
        }

        # 4. Отримуємо RAM (CIM зазвичай працює краще для віддалених запитів)
        try {
            $ram = Get-CimInstance Win32_OperatingSystem -ComputerName $pc -ErrorAction Stop
            $usedRAM = [math]::Round((($ram.TotalVisibleMemorySize - $ram.FreePhysicalMemory) / $ram.TotalVisibleMemorySize) * 100, 2)
        } catch {
            $usedRAM = 0
        }

        # 5. Перевірка RAM > 70
        $warning = if ($usedRAM -gt 70) { "HIGH RAM USAGE" } else { "OK" }

        # 6. HashTable для звіту
        $info = [PSCustomObject]@{
            Computer  = $pc
            Processes = if ($procCount) { $procCount } else { "Access Denied" }
            RAM_Usage = "$usedRAM %"
            Status    = $warning
        }
        $Report += $info

    } else {
        Write-Host "$pc is OFFLINE" -ForegroundColor Red
        $Report += [PSCustomObject]@{
            Computer  = $pc
            Processes = "N/A"
            RAM_Usage = "N/A"
            Status    = "OFFLINE"
        }
    }
}

# 7. Збереження у файл
$Report | Format-Table -AutoSize | Out-File "classroom_report.txt" -Encoding utf8

Write-Host "`nReport saved to classroom_report.txt" -ForegroundColor Yellow