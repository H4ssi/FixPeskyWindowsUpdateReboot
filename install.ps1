$Executable = "$env:ProgramFiles\pwu\pwu.exe"
New-Item -ItemType File -Path $Executable -Force
Copy-Item "$pwd\pwu\bin\Release\pwu.exe" -Destination $Executable

$Principal = New-ScheduledTaskPrincipal -UserId SYSTEM -LogonType ServiceAccount
$Trigger = New-ScheduledTaskTrigger -AtStartup
$Settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries
$Settings.ExecutionTimeLimit = "PT0H" # setting ExecutionTimeLimit with constructor won't work
$Action = New-ScheduledTaskAction -Execute $Executable
try {
    Register-ScheduledTask -TaskName "FixPeskyWindowsUpdateReboot" -Principal $Principal -Trigger $Trigger -Settings $Settings -Action $Action -ErrorAction Stop
} catch {
    write-host "Exception Type: $($_.Exception.Message)" -ForegroundColor RED
    If ($_.Exception.Message -match "Access is denied") {
        write-host "You may try running the script with Administrator privileges"
    }
}
