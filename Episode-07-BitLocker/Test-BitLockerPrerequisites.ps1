<#
.SYNOPSIS
Checks BitLocker prerequisites on a Windows device.

.DESCRIPTION
Used in TayStack Episode 7 while troubleshooting the
silent BitLocker deployment to LAB-PC01.
#>

Write-Host "TPM Status" -ForegroundColor Cyan

Get-Tpm |
    Select-Object TpmPresent, TpmReady, TpmEnabled, TpmActivated

Write-Host "`nWindows Recovery Environment" -ForegroundColor Cyan

reagentc /info

Write-Host "`nSecure Boot Status" -ForegroundColor Cyan

Confirm-SecureBootUEFI
