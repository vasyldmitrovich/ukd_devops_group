$Computers = @($env:COMPUTERNAME, "127.0.0.1") 
$ReportPath = "classroom_report.txt"

# Створюємо заголовок звіту
"REPORT FROM $(Get-Date)" | Out-File $ReportPath

foreach ($comp in $Computers) {
    Write-Host "Checking $comp..."
    if (Test-Connection -ComputerName $comp -Count 1 -Quiet) {
        $procs = (Get-Process).Count
        
        # RAM Calculation
        $os = Get-WmiObject Win32_OperatingSystem
        $pctFree = ($os.FreePhysicalMemory / $os.TotalVisibleMemorySize) * 100
        $usage = 100 - $pctFree

        $line = "PC: $comp | Processes: $procs | RAM: $([Math]::Round($usage, 1))%"
        $line | Out-File $ReportPath -Append
        Write-Host $line -ForegroundColor Green
    } else {
        "PC $comp is offline" | Out-File $ReportPath -Append
        Write-Host "PC $comp is offline" -ForegroundColor Red
    }
}