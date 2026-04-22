$PSVersionTable
$env:COMPUTERNAME
$env:USERNAME

$ComputerName = $env:COMPUTERNAME
$User = $env:USERNAME
$Number = 10

$Number.GetType()

Get-Process
Get-Service
Get-ComputerInfo

$procCount = (Get-Process).Count

if ($procCount -gt 100) {
    "System busy"
} else {
    "System normal"
}

$Processes = Get-Process | Select-Object -First 5

foreach ($p in $Processes) {
    $p.Name
}

for ($i = 1; $i -le 5; $i++) {
    $i
}

$PCInfo = @{
    Computer = $env:COMPUTERNAME
    User = $env:USERNAME
    Date = Get-Date
}

$PCInfo