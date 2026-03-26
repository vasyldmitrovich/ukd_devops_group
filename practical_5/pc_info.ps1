Clear-Host
Write-Host "--- ПОВНА ДІАГНОСТИКА СИСТЕМИ ---" -ForegroundColor Cyan -BackgroundColor DarkBlue

Write-Host "`n[1] ОСНОВНА ІНФОРМАЦІЯ" -ForegroundColor Yellow
$PSVersion = $PSVersionTable.PSVersion
$OS = Get-CimInstance Win32_OperatingSystem
Write-Host "PowerShell: $($PSVersion.Major).$($PSVersion.Minor)"
Write-Host "Комп'ютер: $env:COMPUTERNAME"
Write-Host "Користувач: $env:USERNAME"
Write-Host "ОС: $($OS.Caption) (Версія: $($OS.Version))"

Write-Host "`n[2] ТЕХНІЧНІ ХАРАКТЕРИСТИКИ" -ForegroundColor Yellow
$CPU = Get-CimInstance Win32_Processor
$RAM = Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum
$Disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'"

Write-Host "Процесор: $($CPU.Name)"
Write-Host "Ядер/Потоків: $($CPU.NumberOfCores) / $($CPU.NumberOfLogicalProcessors)"
Write-Host "Оперативна пам'ять: $([math]::Round($RAM.Sum / 1GB, 2)) GB"
Write-Host "Диск C: $([math]::Round($Disk.Size / 1GB, 2)) GB (Вільно: $([math]::Round($Disk.FreeSpace / 1GB, 2)) GB)"

$Number = 10
Write-Host "`n[3] ТИПИ ДАНИХ" -ForegroundColor Yellow
Write-Host "Змінна `$Number має тип: $($Number.GetType().Name)"

$procCount = (Get-Process).Count
$svcCount = (Get-Service).Count
Write-Host "`n[4] АКТИВНІСТЬ" -ForegroundColor Yellow
Write-Host "Запущено процесів: $procCount"
Write-Host "Запущено служб: $svcCount"

if ($procCount -gt 100) {
    Write-Host "Статус: System busy (Навантаження високе)" -ForegroundColor Red
} else {
    Write-Host "Статус: System normal" -ForegroundColor Green
}

Write-Host "`n[5] ТОП 5 ПРОЦЕСІВ" -ForegroundColor Yellow
$Processes = Get-Process | Sort-Object CPU -Descending | Select-Object -First 5
foreach ($p in $Processes) {
    Write-Host "- $($p.Name) (CPU: $([math]::Round($p.CPU, 1)))"
}

$PCInfo = @{
    Computer = $env:COMPUTERNAME
    User     = $env:USERNAME
    Date     = Get-Date
    RAM_GB   = [math]::Round($RAM.Sum / 1GB, 2)
}
Write-Host "`n[6] HASHTABLE (ЗВЕДЕНІ ДАНІ)" -ForegroundColor Yellow
$PCInfo | Format-Table -AutoSize