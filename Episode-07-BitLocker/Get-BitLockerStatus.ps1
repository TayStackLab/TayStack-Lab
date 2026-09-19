<#
.SYNOPSIS
Displays the current BitLocker status of the device.

.DESCRIPTION
Used in TayStack Episode 7 to verify the encryption and
protection state of the Windows operating system volume.
#>

Get-BitLockerVolume |
    Select-Object MountPoint, VolumeStatus, ProtectionStatus, EncryptionPercentage, EncryptionMethod

Write-Host "`nDetailed BitLocker Status" -ForegroundColor Cyan

manage-bde -status C:
