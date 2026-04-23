$Computers = @($env:COMPUTERNAME, "PC-02", "PC-03", "PC-04", "Server-01")
$ReportFile = "classroom_report.txt"

"=== CLASSROOM DIAGNOSTIC REPORT [$(Get-Date)] ===" > $ReportFile
"------------------------------------------------" >> $ReportFile

foreach ($PC in $Computers) {
    Write-Host "Checking $PC..." -ForegroundColor Cyan
    
    if (Test-Connection -ComputerName $PC -Count 1 -Quiet) {
        try {
            if ($PC -eq $env:COMPUTERNAME) {
                $OS = Get-CimInstance Win32_OperatingSystem
                $ProcCount = (Get-Process).Count
            }
            else {
                $OS = Get-CimInstance Win32_OperatingSystem -ComputerName $PC -ErrorAction Stop
                $ProcCount = (Get-Process -ComputerName $PC -ErrorAction Stop).Count
            }

            $TotalRAM = $OS.TotalVisibleMemorySize
            $FreeRAM = $OS.FreePhysicalMemory
            $UsedRAMPercent = [Math]::Round((($TotalRAM - $FreeRAM) / $TotalRAM) * 100, 2)

            $PCStatus = @{
                Name      = $PC
                Status    = "Online"
                Processes = $ProcCount
                RAM_Usage = "$UsedRAMPercent%"
            }

            "Computer: $($PCStatus.Name)" >> $ReportFile
            "Status: $($PCStatus.Status)" >> $ReportFile
            "Processes: $($PCStatus.Processes)" >> $ReportFile
            "RAM Usage: $($PCStatus.RAM_Usage)" >> $ReportFile

            if ($UsedRAMPercent -gt 70) {
                $Warning = "!!! WARNING: High RAM usage on $PC ($UsedRAMPercent%) !!!"
                Write-Host $Warning -ForegroundColor Red
                $Warning >> $ReportFile
            }
            
            Write-Host "✅ Data collected from $PC" -ForegroundColor Green
        }
        catch {
            Write-Host "❌ Access Denied/WinRM Error on $PC" -ForegroundColor Yellow
            "Computer: $PC | Status: Online (Access Denied)" >> $ReportFile
        }
    }
    else {
        Write-Host "$PC is Offline" -ForegroundColor Gray
        "Computer: $PC | Status: Offline" >> $ReportFile
    }

    "------------------------------------------------" >> $ReportFile
}

Write-Host "Done! Report saved to $ReportFile" -ForegroundColor Green