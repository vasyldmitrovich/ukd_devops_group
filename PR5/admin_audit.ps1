# --- РІВЕНЬ 5: АДМІНІСТРАТОР ДОМЕНУ ---

function Get-AdminAudit {
    param(
        [string[]]$PCList = @("localhost") # Параметр: список ПК
    )

    $Results = @()

    foreach ($pc in $PCList) {
        try {
            Write-Host "Аудит ПК: $pc" -ForegroundColor Cyan
            if (Test-Connection -ComputerName $pc -Count 1 -ErrorAction Stop) {
                
                # Отримуємо дані
                $os = (Get-ComputerInfo).WindowsProductName
                $psVer = $PSVersionTable.PSVersion.ToString()
                $usersCount = (Get-CimInstance Win32_OperatingSystem).NumberOfUsers
                $topProcesses = Get-Process | Sort-Object CPU -Descending | Select-Object -First 5 | Select-Object -ExpandProperty Name
                
                # Створюємо CustomObject (професійний підхід замість просто тексту)
                $AuditObject = [PSCustomObject]@{
                    ComputerName  = $pc
                    OS            = $os
                    PS_Version    = $psVer
                    Active_Users  = $usersCount
                    Top_Processes = $topProcesses -join ", "
                    Time          = Get-Date
                }
                $Results += $AuditObject
            }
        } catch {
            # Логування помилок (якщо ПК недоступний)
            "$(Get-Date): Помилка доступу до $pc - $($_.Exception.Message)" | Out-File "errors.log" -Append
        }
    }

    # Збереження у CSV (для Excel)
    $Results | Export-Csv -Path "audit_results.csv" -NoTypeInformation -Encoding UTF8
    Write-Host "Аудит завершено. Дані в 'audit_results.csv', помилки в 'errors.log'" -ForegroundColor Yellow
}

# Виклик функції
Get-AdminAudit -PCList @("localhost", "192.168.1.100")


