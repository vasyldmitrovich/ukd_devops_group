param(
    [string[]]$Computers = @("PC1","PC2","PC3")
)

$ErrorLog = "errors.log"
$Report = @()

function Get-PCInfo {
    param($pc)

    try {
        if (Test-Connection -ComputerName $pc -Count 1 -Quiet) {

            $os = (Get-CimInstance Win32_OperatingSystem -ComputerName $pc).Caption
            $psVersion = Invoke-Command -ComputerName $pc { $PSVersionTable.PSVersion.ToString() }

            $users = (Get-CimInstance Win32_ComputerSystem -ComputerName $pc).UserName

            $topCPU = Get-Process -ComputerName $pc |
                      Sort-Object CPU -Descending |
                      Select-Object -First 5 Name, CPU

            return [PSCustomObject]@{
                Computer = $pc
                OS = $os
                PSVersion = $psVersion
                User = $users
                TopCPU = ($topCPU | Out-String)
            }

        } else {
            return [PSCustomObject]@{
                Computer = $pc
                Status = "Offline"
            }
        }

    } catch {
        $_ | Out-File $ErrorLog -Append

        return [PSCustomObject]@{
            Computer = $pc
            Status = "Error"
        }
    }
}

foreach ($pc in $Computers) {
    $Report += Get-PCInfo $pc
}

# Збереження
$Report | Export-Csv "audit.csv" -NoTypeInformation

Write-Host "Audit completed. Results saved to audit.csv"