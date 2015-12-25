try {
    Unregister-ScheduledTask -TaskName "FixPeskyWindowsUpdateReboot" -Confirm:$false -ErrorAction Stop
} catch {
    write-host "Exception Type: $($_.Exception.Message)" -ForegroundColor RED
    If ($_.Exception.Message -match "Access is denied") {
        write-host "You may try running the script with Administrator privileges"
    }
}
