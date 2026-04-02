function Get-AdminAudit {
    param($PCList)
    $FinalData = @()

    foreach ($pc in $PCList) {
        try {
            Write-Host "Auditing $pc..." -NoNewline
            $info = Get-WmiObject Win32_OperatingSystem -ComputerName $pc -ErrorAction Stop
            
            $obj = [PSCustomObject]@{
                Name = $pc
                OS   = $info.Caption
                PS   = $PSVersionTable.PSVersion.ToString()
                TopProcess = (Get-Process | Sort CPU -Descending | Select -First 1).Name
                Status = "Success"
            }
            $FinalData += $obj
            Write-Host " DONE" -ForegroundColor Green
        } catch {
            "$(Get-Date): Error accessing $pc" | Out-File "errors.log" -Append
            Write-Host " FAILED" -ForegroundColor Red
        }
    }
    return $FinalData
}

$report = Get-AdminAudit -PCList @($env:COMPUTERNAME, "localhost")
$report | Export-Csv "audit.csv" -NoTypeInformation
$report | Format-Table
Write-Host "Audit complete. Check audit.csv and errors.log"