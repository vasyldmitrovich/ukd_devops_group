# 1️⃣ Intro
Write-Host "--- Check environment ---" -ForegroundColor Cyan
Write-Host "Version PowerShell: $($PSVersionTable.PSVersion)"
Write-Host "PC name: $env:COMPUTERNAME"
Write-Host "Username: $env:USERNAME"
Write-Host ""

# 2️⃣ Variables
$ComputerName = $env:COMPUTERNAME
$User = $env:USERNAME
$Number = 10
Write-Host "Type var `$Number: $($Number.GetType().Name)"
Write-Host ""

# 3️⃣ Cmdlets (ТУТ ВАЖЛИВО: додаємо .Count)
$allProcesses = Get-Process
$allServices = Get-Service
$osInfo = Get-CimInstance Win32_OperatingSystem

$procCount = $allProcesses.Count
$svcCount = $allServices.Count

Write-Host "Processes running: $procCount"
Write-Host "Services total: $svcCount"
Write-Host "OS: $($osInfo.Caption)"
Write-Host ""

# 4️⃣ Operators
Write-Host "Sys status"
if ($procCount -gt 100) {
    Write-Host "Status: System busy" -ForegroundColor Red
} else {
    Write-Host "Status: System normal" -ForegroundColor Green
}
Write-Host ""

# 5️⃣ Arrays
Write-Host "--- First 5 processes ---"
$Processes = Get-Process | Select-Object -First 5
foreach ($p in $Processes) {
    Write-Host "Process: $($p.Name)"
}
Write-Host ""

# 6️⃣ Loops
Write-Host "--- Cycle for (1-5) ---"
for ($i = 1; $i -le 5; $i++) {
    Write-Host "Number: $i"
}
Write-Host ""

# 7️⃣ HashTable
Write-Host "--- HASHTABLE ---"
$PCInfo = @{
    Computer = $ComputerName
    User     = $User
    Date     = Get-Date
}
$PCInfo