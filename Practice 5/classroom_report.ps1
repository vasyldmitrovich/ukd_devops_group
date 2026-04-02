$ReportFile = "classroom_report.txt"
# Створюємо масив ПК (додав localhost для успішного тесту та вигаданий ПК для помилки)
$Computers = @("localhost", "127.0.0.1", "NonExistentPC1", "NonExistentPC2", $env:COMPUTERNAME)

# Очищаємо файл перед новим записом
Out-File -FilePath $ReportFile -InputObject "=== Звіт по класу ($(Get-Date)) ==="

foreach ($PC in $Computers) {
    # Перевіряємо доступність (ping)
    if (Test-Connection -ComputerName $PC -Count 1 -Quiet -ErrorAction SilentlyContinue) {
        $procCount = (Get-Process -ComputerName $PC -ErrorAction SilentlyContinue).Count
        
        # Отримуємо використання RAM (використовуємо CIM для швидкості)
        $os = Get-CimInstance Win32_OperatingSystem -ComputerName $PC
        $ramUsagePct = [math]::Round((($os.TotalVisibleMemorySize - $os.FreePhysicalMemory) / $os.TotalVisibleMemorySize) * 100, 2)

        # Формуємо HashTable для зручності
        $Data = @{
            Computer = $PC
            Status = "Online"
            Processes = $procCount
            RAM_Usage = "$ramUsagePct%"
        }

        $OutputMsg = "ПК: $($Data.Computer) | Процесів: $($Data.Processes) | RAM: $($Data.RAM_Usage)"
        
        # Перевірка на використання RAM
        if ($ramUsagePct -gt 70) {
            $OutputMsg += " [УВАГА: RAM > 70%]"
            Write-Host $OutputMsg -ForegroundColor Yellow
        } else {
            Write-Host $OutputMsg -ForegroundColor Green
        }

        # Записуємо у файл
        $OutputMsg | Out-File -FilePath $ReportFile -Append
    } else {
        $ErrorMsg = "ПК: $PC | Status: Offline"
        Write-Host $ErrorMsg -ForegroundColor Red
        $ErrorMsg | Out-File -FilePath $ReportFile -Append
    }
}