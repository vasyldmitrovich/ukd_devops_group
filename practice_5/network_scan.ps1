param (
    [string]$Start = "192.168.1.1",
    [string]$End = "192.168.1.10",
    [string]$ReportPath = "network_scan_report.csv"
)

function Get-IPRange ($startIP, $endIP) {
    $startAddr = [System.Net.IPAddress]::Parse($startIP).GetAddressBytes()
    [Array]::Reverse($startAddr)
    $startInt = [BitConverter]::ToUInt32($startAddr, 0)

    $endAddr = [System.Net.IPAddress]::Parse($endIP).GetAddressBytes()
    [Array]::Reverse($endAddr)
    $endInt = [BitConverter]::ToUInt32($endAddr, 0)

    for ($i = $startInt; $i -le $endInt; $i++) {
        $bytes = [BitConverter]::GetBytes($i)
        [Array]::Reverse($bytes)
        ([System.Net.IPAddress]$bytes).IPAddressToString
    }
}

$IPList = Get-IPRange $Start $End
$Results = @()

Write-Host "=== SCANNING NETWORK: $Start - $End ===" -ForegroundColor Cyan

foreach ($IP in $IPList) {
    Write-Host "Checking $IP... " -NoNewline
    
    if (Test-Connection -ComputerName $IP -Count 1 -Quiet) {
        try {
            $isLocal = ($IP -eq "127.0.0.1" -or $IP -eq "localhost" -or (Get-NetIPAddress).IPAddress -contains $IP)
            
            if ($isLocal) {
                $os = Get-CimInstance Win32_OperatingSystem
                $cpu = Get-CimInstance Win32_Processor
                $proc = Get-Process | Sort-Object CPU -Descending | Select-Object -First 5
                $users = (Get-CimInstance Win32_LoggedOnUser).Antecedent.Name | Select-Object -Unique
            } else {
                $os = Get-CimInstance Win32_OperatingSystem -ComputerName $IP -ErrorAction Stop
                $cpu = Get-CimInstance Win32_Processor -ComputerName $IP -ErrorAction Stop
                $proc = Get-Process -ComputerName $IP -ErrorAction Stop | Sort-Object CPU -Descending | Select-Object -First 5
                $users = (Get-CimInstance Win32_LoggedOnUser -ComputerName $IP).Antecedent.Name | Select-Object -Unique
            }

            $Results += [PSCustomObject]@{
                IP           = $IP
                ComputerName = $os.CSName
                OS           = $os.Caption
                CPULoad      = "$($cpu.LoadPercentage)%"
                TopProcesses = ($proc.Name -join ", ")
                LoggedUsers  = if ($users) { $users -join ", " } else { "None" }
            }
            Write-Host "[ONLINE]" -ForegroundColor Green
        }
        catch {
            Write-Host "[ACCESS DENIED]" -ForegroundColor Yellow
            $Results += [PSCustomObject]@{ IP = $IP; ComputerName = "Access Denied"; OS = "N/A"; CPULoad = "N/A"; TopProcesses = "N/A"; LoggedUsers = "N/A" }
        }
    } else {
        Write-Host "[OFFLINE]" -ForegroundColor Gray
    }
}

if ($Results.Count -gt 0) {
    $Results | Export-Csv -Path $ReportPath -NoTypeInformation -Encoding UTF8 -Delimiter ";"
    Write-Host "`n✅ Report saved to: $ReportPath" -ForegroundColor Green
}

Write-Host "Scan finished." -ForegroundColor Cyan