$Computers = $env:COMPUTERNAME, "127.0.0.1", "google.com", "ukd.edu.ua"
$ReportPath = "$PSScriptRoot\classroom_report.txt"

"--- CLASSROOM ANALYSIS REPORT: $(Get-Date) ---" | Out-File $ReportPath

foreach ($comp in $Computers) {
    Write-Host "Checking $comp..." -NoNewline
    
    if (Test-Connection -ComputerName $comp -Count 1 -Quiet) {
        Write-Host " [ONLINE]" -ForegroundColor Green
        
        $procCount = (Get-Process).Count
        
        $os = Get-CimInstance Win32_OperatingSystem
        $ramUsage = [math]::Round(100 - ($os.FreePhysicalMemory / $os.TotalVisibleMemorySize * 100), 1)
        
        $result = "PC ${comp}: Processes: $procCount, RAM Usage: ${ramUsage}%"
        
        if ($ramUsage -gt 70) { $result += " [WARNING: High RAM Usage!]" }
        
        $result | Out-File $ReportPath -Append
    } else {
        Write-Host " [OFFLINE]" -ForegroundColor Red
        "PC ${comp}: Not Reachable" | Out-File $ReportPath -Append
    }
}
Write-Host "`nReport saved to: $ReportPath" -ForegroundColor Cyan