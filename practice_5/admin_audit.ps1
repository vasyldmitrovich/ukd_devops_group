<#
.SYNOPSIS
    Admin Audit Script
#>

param (
    [array]$ComputerList = @($env:COMPUTERNAME, "PC-02", "Server-01"),
    [string]$ReportPath = "audit_report.csv",
    [string]$ErrorLog = "errors.log"
)

function Get-PCAudit {
    param ([string]$Computer)

    try {
        $isLocal = ($Computer -eq $env:COMPUTERNAME -or $Computer -eq "localhost")
        
        if ($isLocal) {
            $os = Get-CimInstance Win32_OperatingSystem
            $processes = Get-Process | Sort-Object CPU -Descending | Select-Object -First 5
            # Рахуємо кількість користувачів
            $usersCount = (Get-CimInstance Win32_UserAccount).Count
        } else {
            $os = Get-CimInstance Win32_OperatingSystem -ComputerName $Computer -ErrorAction Stop
            $processes = Get-Process -ComputerName $Computer -ErrorAction Stop | Sort-Object CPU -Descending | Select-Object -First 5
            $usersCount = (Get-CimInstance Win32_UserAccount -ComputerName $Computer -ErrorAction Stop).Count
        }

        [PSCustomObject]@{
            "Computer Name" = $Computer
            "OS Version"    = $os.Caption
            "PS Version"    = $PSVersionTable.PSVersion.ToString()
            "Users Active"  = $usersCount
            "Top 5 CPU"     = ($processes.Name -join ", ")
            "Report Date"   = Get-Date -Format "yyyy-MM-dd HH:mm"
        }
    }
    catch {
        "$(Get-Date) | ERROR | $Computer | $($_.Exception.Message)" | Out-File -FilePath $ErrorLog -Append
        return $null
    }
}

$Results = @()
Write-Host "=== Start audit sys ===" -ForegroundColor Cyan

foreach ($PC in $ComputerList) {
    Write-Host "Check: $PC..." -NoNewline
    
    if (Test-Connection -ComputerName $PC -Count 1 -Quiet) {
        $auditData = Get-PCAudit -Computer $PC
        if ($auditData) {
            $Results += $auditData
            Write-Host " [OK]" -ForegroundColor Green
        } else {
            Write-Host " [ACCESS DENIED]" -ForegroundColor Yellow
        }
    } else {
        Write-Host " [OFFLINE]" -ForegroundColor Gray
        "$(Get-Date) | OFFLINE | $PC" | Out-File -FilePath $ErrorLog -Append
    }
}

if ($Results.Count -gt 0) {
    $Results | Export-Csv -Path $ReportPath -NoTypeInformation -Encoding UTF8 -Delimiter ";"
    Write-Host "`nReport saved to: $ReportPath" -ForegroundColor Green
}

Write-Host "Audit ended." -ForegroundColor Cyan