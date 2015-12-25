$Name = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
$Principal = New-ScheduledTaskPrincipal -UserId $Name -LogonType S4U
$Time = New-ScheduledTaskTrigger -At "00:00" -Once -RepetitionInterval "00:05:00"
$Action = New-ScheduledTaskAction -Execute PowerShell -Argument '-NoLogo -NonInteractive -Command "Disable-ScheduledTask Reboot \Microsoft\Windows\UpdateOrchestrator\ "'
try {
    Register-ScheduledTask -TaskName "FixPeskyWindowsUpdateReboot" -Principal $Principal -Trigger $Time -Action $Action -ErrorAction Stop
} catch {
    write-host "Exception Type: $($_.Exception.Message)" -ForegroundColor RED
    If ($_.Exception.Message -match "Access is denied") {
        write-host "You may try running the script with Administrator privileges"
    }
}
