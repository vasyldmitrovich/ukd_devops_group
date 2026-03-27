param(
    # Приймаємо масив комп'ютерів як параметр. За замовчуванням - тільки поточний.
    [string[]]$ComputerList = @("localhost", "127.0.0.1")
)

$ErrorLog = "errors.log"
$ReportCSV = "audit_report.csv"
$Results = @() # Порожній масив для збору результатів

# Функція для перевірки конкретного ПК
function Get-AuditData {
    param([string]$ComputerName)

    try {
        if (Test-Connection -ComputerName $ComputerName -Count 1 -Quiet -ErrorAction Stop) {
            
            # Збираємо дані
            $os = Get-CimInstance Win32_OperatingSystem -ComputerName $ComputerName
            $users = (Get-CimInstance Win32_ComputerSystem -ComputerName $ComputerName).NumberOfLogicalProcessors # Як приклад метрики
            $topProcess = (Get-Process -ComputerName $ComputerName | Sort-Object CPU -Descending | Select-Object -First 1).Name

            # Створюємо кастомний об'єкт
            $PCData = [PSCustomObject]@{
                ComputerName = $ComputerName
                Status       = "Online"
                OS_Version   = $os.Caption
                PS_Version   = $PSVersionTable.PSVersion.ToString()
                Top_CPU_Proc = $topProcess
            }
            return $PCData
        }
    } catch {
        # Записуємо помилку в лог
        $ErrorMessage = "$(Get-Date) - Помилка підключення до $ComputerName : $_"
        $ErrorMessage | Out-File -FilePath $ErrorLog -Append
        
        return [PSCustomObject]@{
            ComputerName = $ComputerName
            Status       = "Offline"
            OS_Version   = "N/A"
            PS_Version   = "N/A"
            Top_CPU_Proc = "N/A"
        }
    }
}

# Головний цикл скрипта
Write-Host "Починаємо аудит..." -ForegroundColor Cyan
foreach ($PC in $ComputerList) {
    Write-Host "Сканування $PC ..."
    $Data = Get-AuditData -ComputerName $PC
    $Results += $Data
}

# Зберігаємо результати у CSV
$Results | Export-Csv -Path $ReportCSV -NoTypeInformation -Encoding UTF8
Write-Host "Аудит завершено! Звіт збережено у $ReportCSV, логи помилок у $ErrorLog" -ForegroundColor Green