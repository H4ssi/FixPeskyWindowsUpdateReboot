$Name = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
$Principal = New-ScheduledTaskPrincipal -UserId $Name -LogonType S4U
$Trigger = New-ScheduledTaskTrigger -AtStartup
$Settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries
$Settings.ExecutionTimeLimit = "PT0H" # setting ExecutionTimeLimit with constructor won't work
$Action = New-ScheduledTaskAction -Execute "$pwd\pwu\bin\Release\pwu.exe"
try {
    Register-ScheduledTask -TaskName "FixPeskyWindowsUpdateReboot" -Principal $Principal -Trigger $Trigger -Settings $Settings -Action $Action -ErrorAction Stop
} catch {
    write-host "Exception Type: $($_.Exception.Message)" -ForegroundColor RED
    If ($_.Exception.Message -match "Access is denied") {
        write-host "You may try running the script with Administrator privileges"
    }
}
