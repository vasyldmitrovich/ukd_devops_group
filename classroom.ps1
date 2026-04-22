# =========================
# CLASSROOM ANALYSIS
# =========================

# 1. Масив комп’ютерів
$Computers = @(
    "localhost",
    "127.0.0.1",
    $env:COMPUTERNAME,
    "computer4",
    "computer5"
)

# Файл результату
$ReportFile = "classroom_report.txt"

# очищаємо файл перед стартом
"" | Out-File $ReportFile


# 2. Перебір комп’ютерів
foreach ($pc in $Computers) {

    Write-Host "`nChecking $pc..." -ForegroundColor Cyan

    # 3. Перевірка доступності
    $isAlive = Test-Connection -ComputerName $pc -Count 1 -Quiet

    # HashTable для збереження даних
    $result = @{
        Computer = $pc
        Online = $isAlive
        Processes = 0
        RAM_Usage = 0
        Warning = ""
    }

    if ($isAlive) {

        # 4. Процеси
        $procCount = (Get-Process).Count
        $result.Processes = $procCount

        # 5. RAM (приблизно через WMI)
        $os = Get-CimInstance Win32_OperatingSystem
        $total = $os.TotalVisibleMemorySize
        $free = $os.FreePhysicalMemory

        $usedPercent = [math]::Round((($total - $free) / $total) * 100, 2)

        $result.RAM_Usage = $usedPercent

        # 6. Перевірка RAM
        if ($usedPercent -gt 70) {
            $result.Warning = "HIGH RAM USAGE"
            Write-Host "WARNING: RAM > 70%" -ForegroundColor Red
        }
        else {
            $result.Warning = "OK"
        }
    }

    # 7. Вивід у файл
    $result | Out-File -Append $ReportFile
}

Write-Host "`nDONE. Report saved to classroom_report.txt"