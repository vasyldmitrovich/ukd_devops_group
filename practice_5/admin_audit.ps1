param(
    [string[]]$Computers = @("localhost", "127.0.0.1", "8.8.8.8", "invalid-host")
)

function Get-PCInfo {
    param($pc)

    try {
        Write-Host "Checking $pc..."

        # Перевірка доступності
        if (-not (Test-Connection -ComputerName $pc -Count 1 -Quiet)) {
            throw "$pc is OFFLINE"
        }

        # Якщо це локальний ПК — беремо повну інформацію
        if ($pc -eq "localhost" -or $pc -eq "127.0.0.1") {

            $os = (Get-CimInstance Win32_OperatingSystem).Caption
            $ps = $PSVersionTable.PSVersion.ToString()
            $users = (Get-LocalUser).Count
            $topCPU = Get-Process | Sort-Object CPU -Descending | Select-Object -First 5

        }
        else {
            # Для віддалених ПК (щоб не падало)
            $os = "Unknown (remote)"
            $ps = "Unknown"
            $users = "N/A"
            $topCPU = @()
        }

        return [PSCustomObject]@{
            Computer     = $pc
            Status       = "Online"
            OS           = $os
            PowerShell   = $ps
            Users        = $users
            TopProcesses = ($topCPU.Name -join ", ")
        }

    }
    catch {
        # Запис помилки в лог
        $errorMessage = "$(Get-Date) - $($_.Exception.Message)"
        $errorMessage | Out-File -Append "errors.log"

        return [PSCustomObject]@{
            Computer     = $pc
            Status       = "Offline"
            OS           = "N/A"
            PowerShell   = "N/A"
            Users        = "N/A"
            TopProcesses = "N/A"
        }
    }
}

# Основна логіка
$results = @()

foreach ($pc in $Computers) {
    $data = Get-PCInfo $pc
    $results += $data
}

# 🔥 Гарантовано створює файл
$results | Export-Csv -Path "audit.csv" -NoTypeInformation -Encoding UTF8

Write-Host "Audit complete!"
Write-Host "Check files: audit.csv and errors.log"