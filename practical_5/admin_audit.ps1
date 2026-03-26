function Get-ComputerAudit {
    param([string]$ComputerName)
    
    try {
        if (Test-Connection -ComputerName $ComputerName -Count 1 -Quiet) {
            $os = (Get-CimInstance Win32_OperatingSystem).Caption
            
            $psVer = $PSVersionTable.PSVersion.ToString()
            
            $usersCount = (Get-CimInstance Win32_ComputerSystem).NumberOfLoggedOnUsers
            if ($null -eq $usersCount) { $usersCount = 1 } 
            
            $top5 = Get-Process | Sort-Object CPU -Descending | Select-Object -First 5 | ForEach-Object { "$($_.Name)" }
            $top5String = $top5 -join ", "
            
            return [PSCustomObject]@{
                Computer   = $ComputerName
                Status     = "Online"
                OS         = $os
                PSVersion  = $psVer
                Users      = $usersCount
                TopCPU     = $top5String
            }
        } else {
            throw "Host $ComputerName is unreachable"
        }
    } catch {
        "$(Get-Date): ERROR on $ComputerName - $($_.Exception.Message)" | Out-File "$PSScriptRoot\errors.log" -Append
        return $null
    }
}

$Targets = $env:COMPUTERNAME, "127.0.0.1", "non-existent-pc"

Write-Host "Starting Audit..." -ForegroundColor Cyan

$Results = foreach ($t in $Targets) { Get-ComputerAudit -ComputerName $t }

$Results | Where-Object { $null -ne $_ } | Format-Table -AutoSize

$Results | Where-Object { $null -ne $_ } | Export-Csv -Path "$PSScriptRoot\admin_audit.csv" -NoTypeInformation -Encoding UTF8

Write-Host "`nAudit finished!" -ForegroundColor Green
Write-Host "Results saved to admin_audit.csv"
Write-Host "Errors (if any) logged to errors.log"