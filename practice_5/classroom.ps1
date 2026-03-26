$Computers = @("localhost", "google.com", "192.168.1.1", "8.8.8.8", "invalid-host")

$Report = @()

foreach ($pc in $Computers) {

    Write-Host "Checking $pc ..."

    if (Test-Connection -ComputerName $pc -Count 1 -Quiet) {

        Write-Host "$pc is ONLINE"

        $procCount = (Get-Process).Count
        $ram = Get-CimInstance Win32_OperatingSystem
        $usedRAM = (($ram.TotalVisibleMemorySize - $ram.FreePhysicalMemory) / $ram.TotalVisibleMemorySize) * 100

        if ($usedRAM -gt 70) {
            Write-Host "WARNING: High RAM usage!"
        }

        $info = @{
            Computer = $pc
            Processes = $procCount
            RAM_Usage = [math]::Round($usedRAM, 2)
        }

        $Report += $info

    } else {
        Write-Host "$pc is OFFLINE"
    }
}

# Save to file
$Report | Out-File "classroom_report.txt"

Write-Host "Report saved!"