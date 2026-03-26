# Intro — перевірка середовища
$env:USERNAME
$env:COMPUTERNAME
# $PSVersionTable


# Variables + Data types
echo ""
$ComputerName = $env:COMPUTERNAME
$User = $env:USERNAME
$Number = 10

$ComputerName.GetType()
$User.GetType()
$Number.GetType()


# Cmdlets
echo ""
echo "Process count:"
(Get-Process).Count

echo "Service count:"
(Get-Service).Count

# echo "Computer info:"
# Get-ComputerInfo


# Operators
echo ""
if ((Get-Process).Count -gt 100)
{
    echo "System busy"
}
else
{
    echo "System normal"
}


# Arrays
echo ""
$Processes = Get-Process | Select-Object -First 5

foreach ($p in $Processes)
{
    $p.Name
}


#  Loops
echo ""
for ($i = 0; $i -lt 5;$i++)
{
    echo $i
} 


# HashTable
echo ""
$PCInfo = @{
    Computer = $ComputerName
    User = $User
    Date = Get-Date
}

echo $PCInfo



# Завдання: “Аналіз комп’ютерного класу”
$PCs = 'localhost', '8.8.8.8', '192.168.1.2', 'CLASSPC-116'
#$logPath = .\logs\data.log.txt
#$logPath = .\logs\error.log.txt
$logPath = "E:\Programming\Projects\UKD\ukd_devops_group\05_PowerShell_Scripting\logs\data.log.txt"
$errorPath = "E:\Programming\Projects\UKD\ukd_devops_group\05_PowerShell_Scripting\logs\error.log.txt"

foreach ($PC in $PCs)
{
    # Test-Connection $PC
    if (Test-Connection $PC -Quiet) {
        echo "$PC. is online" | Out-File -Append -FilePath $logPath
    } 
    else {
        echo "$PC. is offline" | Out-File -Append -FilePath $errorPath
        continue
    }

    # Process count
    $processCount = (Get-Process).Count
    $serviceCount = (Get-Service).Count
    echo "Process count: $processCount." | Out-File -Append -FilePath $logPath
    echo "Service count: $serviceCount." | Out-File -Append -FilePath $logPath
    
    # Ram usage
    Get-CimInstance Win32_OperatingSystem | Select FreePhysicalMemory, TotalVisibleMemorySize | Out-File -Append -FilePath $logPath
    $os = Get-CimInstance Win32_OperatingSystem
    $usedMemory = (($os.TotalVisibleMemorySize - $os.FreePhysicalMemory) / $os.TotalVisibleMemorySize) * 100

    $usedMemoryPercent = [math]::Round($usedMemory, 2)
    echo "Ram usage percentage: $usedMemoryPercent."  | Out-File -Append -FilePath $logPath
    if ($usedMemoryPercent -gt 70)
    {
        Write-Warning "Used Ram is greater than 70%" | Out-File -Append -FilePath $logPath
    }

    # Users count
    $usersCount = (Get-LocalUser).Count
    echo "Users count: $usersCount." | Out-File -Append -FilePath $logPath
    echo "Current user: $env:USERNAME." | Out-File -Append -FilePath $logPath

    # PowerShell version
    echo "PowerShell version:" | Out-File -Append -FilePath $logPath
    echo $PSVersionTable.PSVersion | Out-File -Append -FilePath $logPath

    # 5 biggest processes
    echo "Biggest processes:" | Out-File -Append -FilePath $logPath
    Get-Process | Sort-Object -Property CPU -descending | Select-Object -First 5 | Out-File -Append -FilePath $logPath


    echo "======================================================" | Out-File -Append -FilePath $logPath

}