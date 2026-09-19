<#
.SYNOPSIS
Decrypts the Windows operating system volume.

.DESCRIPTION
Used in TayStack Episode 7 to return LAB-PC01 to a clean
state before testing the Microsoft Intune BitLocker policy
again.

.WARNING
This script disables BitLocker and decrypts the C: volume.

It was created for use in the TayStack lab environment.
Do not run this against a production device without
understanding and approving the impact.
#>

Write-Warning "This will disable BitLocker and decrypt the C: volume."

Disable-BitLocker -MountPoint "C:"
