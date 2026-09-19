<#
.SYNOPSIS
Displays recent BitLocker Management events.

.DESCRIPTION
Used in TayStack Episode 7 to troubleshoot silent BitLocker
encryption through Microsoft Intune.

The event log identified Event ID 853, which showed that
bootable media was preventing silent encryption.
#>

Get-WinEvent -LogName "Microsoft-Windows-BitLocker/BitLocker Management" -MaxEvents 20 |
    Select-Object TimeCreated, Id, LevelDisplayName, Message |
    Format-List
