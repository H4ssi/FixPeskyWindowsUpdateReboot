$Name = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
$Principal = New-ScheduledTaskPrincipal -UserId $Name -LogonType S4U
$Time = New-ScheduledTaskTrigger -At "00:00" -Once -RepetitionInterval "00:05:00"
$Action = New-ScheduledTaskAction -Execute PowerShell -Argument '-NoLogo -NonInteractive -Command "Set-ScheduledTask Reboot \Microsoft\Windows\UpdateOrchestrator\ -Trigger $(New-ScheduledTaskTrigger -At 2022-2-22-22:22 -Once)"'
Register-ScheduledTask -TaskName "FixPeskyWindowsUpdateReboot" -Principal $Principal -Trigger $Time -Action $Action
