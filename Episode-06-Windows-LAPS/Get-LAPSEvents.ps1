Get-WinEvent -LogName "Microsoft-Windows-LAPS/Operational" -MaxEvents 20 |
    Select-Object TimeCreated, Id, Message |
    Format-List
