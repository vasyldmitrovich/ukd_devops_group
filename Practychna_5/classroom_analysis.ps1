$Computers = @("localhost", "127.0.0.1", $env:COMPUTERNAME)
$ReportPath = "classroom_report.txt"

"--- CLASSROOM REPORT $(Get-Date) ---" | Out-File $ReportPath

foreach ($pc in $Computers) {
    Write-Host "Checking $pc..."
    if (Test-Connection -ComputerName $pc -Count 1 -Quiet) {
        $procs = (Get-Process).Count
        $mem = Get-CimInstance Win32_OperatingSystem
        $usage = [Math]::Round(100 - ($mem.FreePhysicalMemory / $mem.TotalVisibleMemorySize * 100), 2)
        
        $status = "OK"
        if ($usage -gt 70) { $status = "WARNING: High RAM!" }
        
        $line = "PC: $pc | Procs: $procs | RAM: $usage% | Status: $status"
        $line | Out-File $ReportPath -Append
        Write-Host "Success: $pc" -ForegroundColor Green
    } else {
        "PC: $pc | Offline" | Out-File $ReportPath -Append
    }
}
Write-Host "Done! Check classroom_report.txt"