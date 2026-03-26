Write-Host "=== PC INFO SCRIPT ==="

# 1. Intro
Write-Host "PowerShell Version:"
$PSVersionTable.PSVersion

Write-Host "Computer Name:"
$env:COMPUTERNAME

Write-Host "User:"
$env:USERNAME

# 2. Variables
$ComputerName = $env:COMPUTERNAME
$User = $env:USERNAME
$Number = 10

Write-Host "Type of Number:"
$Number.GetType()

# 3. Cmdlets
$procCount = (Get-Process).Count
$serviceCount = (Get-Service).Count

Write-Host "Processes count: $procCount"
Write-Host "Services count: $serviceCount"

Write-Host "OS Info:"
Get-ComputerInfo | Select-Object OSName, OSVersion

# 4. Operators
if ($procCount -gt 100) {
    Write-Host "System busy"
} else {
    Write-Host "System normal"
}

# 5. Arrays
$Processes = Get-Process | Select-Object -First 5

Write-Host "First 5 processes:"
foreach ($p in $Processes) {
    Write-Host $p.Name
}

# 6. Loops
Write-Host "Numbers 1 to 5:"
for ($i = 1; $i -le 5; $i++) {
    Write-Host $i
}

# 7. HashTable
$PCInfo = @{
    Computer = $ComputerName
    User = $User
    Date = Get-Date
}

Write-Host "HashTable:"
$PCInfo