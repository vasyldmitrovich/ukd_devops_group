param(
    [string]$Start,
    [string]$End
)

function Get-IPRange {
    param($startIP, $endIP)

    $start = [System.Net.IPAddress]::Parse($startIP).GetAddressBytes()
    $end = [System.Net.IPAddress]::Parse($endIP).GetAddressBytes()

    [array]::Reverse($start)
    [array]::Reverse($end)

    $startInt = [BitConverter]::ToUInt32($start, 0)
    $endInt = [BitConverter]::ToUInt32($end, 0)

    for ($i = $startInt; $i -le $endInt; $i++) {
        $bytes = [BitConverter]::GetBytes($i)
        [array]::Reverse($bytes)
        ([System.Net.IPAddress]::new($bytes)).ToString()
    }
}

$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
$ips = Get-IPRange $Start $End

$results = @()

foreach ($ip in $ips) {

    Write-Host "Scanning $ip..."

    try {
        # ⚡ швидкий ping (таймаут 1 сек)
        if (Test-Connection -ComputerName $ip -Count 1 -Quiet) {

            try {
                $hostname = [System.Net.Dns]::GetHostEntry($ip).HostName
            } catch {
                $hostname = "Unknown"
            }

            $results += [PSCustomObject]@{
                IP       = $ip
                Hostname = $hostname
                Status   = "Online"
            }

        } else {
            $results += [PSCustomObject]@{
                IP       = $ip
                Hostname = "-"
                Status   = "Offline"
            }
        }
    }
    catch {
        $errorMessage = "$(Get-Date) - $ip error: $($_.Exception.Message)"
        $errorMessage | Out-File -Append "$scriptPath\errors.log"
    }
}

$results | Export-Csv "$scriptPath\network_scan.csv" -NoTypeInformation -Encoding UTF8

Write-Host "Scan complete!"
Write-Host "File created: network_scan.csv"