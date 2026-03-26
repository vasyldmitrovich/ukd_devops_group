function Get-AdminAudit {
    param (
        [string[]]$ComputerList = @("localhost", $env:COMPUTERNAME, "127.0.0.1")
    )

    $Results = @()
    $ErrorLog = "errors.log"

    foreach ($pc in $ComputerList) {
        try {
            Write-Host "Аналіз вузла: $pc..." -NoNewline -ForegroundColor Cyan
            
            if (Test-Connection $pc -Count 1 -Quiet -ErrorAction Stop) {
                
                # ВИПРАВЛЕНО: Використовуємо Get-WmiObject замість Get-CimInstance
                $os = Get-WmiObject Win32_OperatingSystem -ComputerName $pc -ErrorAction Stop
                $cs = Get-WmiObject Win32_ComputerSystem -ComputerName $pc -ErrorAction Stop
                $topProc = Get-Process | Sort-Object WorkingSet -Descending | Select-Object -First 5
                
                $obj = [PSCustomObject]@{
                    Computer    = $pc
                    OS          = $os.Caption
                    PS_Version  = $PSVersionTable.PSVersion.ToString()
                    LoggedUsers = $cs.NumberOfLoggedOnUsers
                    TopProcesses = ($topProc.Name -join ", ")
                    Time        = Get-Date -Format "HH:mm:ss"
                }
                $Results += $obj
                Write-Host " [УСПІШНО]" -ForegroundColor Green
            } else { throw "Offline" }
        } catch {
            Write-Host " [ПОМИЛКА]" -ForegroundColor Red
            "$(Get-Date) | $pc | $($_.Exception.Message)" | Out-File $ErrorLog -Append
        }
    }
    return $Results
}

$finalReport = Get-AdminAudit
$finalReport | Export-Csv -Path "admin_report.csv" -NoTypeInformation -Encoding UTF8
$finalReport | Format-Table