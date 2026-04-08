
$Computers = @("localhost", "127.0.0.1", "google.com", "8.8.8.8")
$FinalReport = @()
foreach ($comp in $Computers) {
    Write-Host "Checking $comp..." -NoNewline
    if (Test-Connection -ComputerName $comp -Count 1 -Quiet) {
        Write-Host " [ONLINE]" -ForegroundColor Green
        $procs = (Get-Process).Count
        $os = Get-CimInstance Win32_OperatingSystem
        $ramPercent = [math]::Round((($os.TotalVisibleMemorySize - $os.FreePhysicalMemory) / $os.TotalVisibleMemorySize) * 100)
        $status = if ($ramPercent -gt 70) { "WARNING: High RAM usage" } else { "Normal" }
        $FinalReport += "Host: $comp | Procs: $procs | RAM: $ramPercent% | Status: $status"
    } else {
        Write-Host " [OFFLINE]" -ForegroundColor Red
        $FinalReport += "Host: $comp | Status: Offline"
    }
}
$FinalReport | Out-File "classroom_report.txt"
Write-Host "Report saved to classroom_report.txt" -ForegroundColor Yellow

