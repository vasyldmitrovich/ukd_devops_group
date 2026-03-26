
param([string[]]$ComputerList = @("localhost", "127.0.0.1"))
function Get-AdminAudit {
    param([string]$Computer)
    try {
        if (Test-Connection -ComputerName $Computer -Count 1 -Quiet -ErrorAction Stop) {
            $os = (Get-CimInstance Win32_OperatingSystem).Caption
            $psVer = $PSVersionTable.PSVersion.ToString()
            $topProcs = Get-Process | Sort-Object CPU -Descending | Select-Object -First 5 | ForEach-Object { $_.Name }
            [PSCustomObject]@{
                ComputerName = $Computer
                OS           = $os
                PSVersion    = $psVer
                TopProcesses = $topProcs -join ", "
                Time         = Get-Date
            }
        } else { throw "Host unreachable" }
    } catch {
        "$(Get-Date) : ERROR : $Computer : $($_.Exception.Message)" | Out-File "errors.log" -Append
        return $null
    }
}
$Results = foreach ($pc in $ComputerList) { Get-AdminAudit -Computer $pc }
$Results | Export-Csv -Path "audit_report.csv" -NoTypeInformation -Encoding UTF8
$Results | Format-Table -AutoSize
Write-Host "Audit Complete. Check audit_report.csv" -ForegroundColor Green

