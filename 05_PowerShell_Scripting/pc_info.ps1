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

foreach ($PC in $PCs)
{
    # Test-Connection $PC

    if (Test-Connection $PC -Quiet) {
    Write-Host "$PC. is online"
    } 
    else {
        Write-Host "$PC. is offline"
    }


}





