# 1. Intro
Write-Host "--- SYSTEM INFO ---" -ForegroundColor Cyan
Write-Host "PS Version: $($PSVersionTable.PSVersion)"
Write-Host "Computer: $env:COMPUTERNAME"
Write-Host "User: $env:USERNAME"

# 2. Variables
$ComputerName = $env:COMPUTERNAME
$User = $env:USERNAME
$Number = 10
Write-Host "Type of Number: $($Number.GetType().Name)"

# 3. Cmdlets
$procCount = (Get-Process).Count
$servCount = (Get-Service).Count
$os = Get-CimInstance Win32_OperatingSystem
Write-Host "Processes: $procCount | Services: $servCount | OS: $($os.Caption)"

# 4. Operators
if ($procCount -gt 100) { Write-Host "System busy" -ForegroundColor Red } else { Write-Host "System normal" }

# 5. Arrays
Write-Host "--- Top 5 Processes ---"
$Processes = Get-Process | Select-Object -First 5
foreach ($p in $Processes) { $p.Name }

# 6. Loops
for ($i=1; $i -le 5; $i++) { Write-Host "Number $i" }

# 7. HashTable
$PCInfo = @{ Computer = $ComputerName; User = $User; Date = Get-Date }
$PCInfo